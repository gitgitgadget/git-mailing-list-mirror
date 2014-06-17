From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v10 1/1] refs.c: SSE2 optimizations for
 check_refname_component
Date: Tue, 17 Jun 2014 14:07:13 -0400
Organization: Twitter
Message-ID: <1403028433.5629.94.camel@stross>
References: <1403025199-21360-1-git-send-email-dturner@twitter.com>
	 <1403025199-21360-2-git-send-email-dturner@twitter.com>
	 <xmqq8uovmn0d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 20:07:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwxn1-0007dO-Fo
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 20:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932858AbaFQSHS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jun 2014 14:07:18 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:42748 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932135AbaFQSHR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 14:07:17 -0400
Received: by mail-qc0-f174.google.com with SMTP id x13so10240376qcv.19
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 11:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=RAiqeGkdTrppHmwDqptrbrtjHYxXDF0lJmVb2yTWg0I=;
        b=IsqUq/6/Bo6HPUah5AfsMN6BiLvw2llDF/PQMSx5CtpCwvX2UBNBu6yww+evYISpL+
         NVzWZYZ3DaXOjnyvh5azNe3Es8MJ0MGBJNDSGG+KLJg1VBxZApBC+eGDanWFFW3ZAZp+
         T8CWym3PgrpKzygi8eRzQ3NSGkSc60hJOOYe5fGlcW5hEgGpcyBpXXvQpzrabfCR7LH6
         UaqxEpaIZkfn3uxJ1cpN/CXm8CrtBvG34ez+cutZkuWpyKi60Tab4XhT5giASxpVdjxr
         m/L3Tc7SCl4w6ac0CSWhm2oyja/drjjtI/burUqkccYVn24fRd91lNjbR9O3nIXHEXJg
         74Og==
X-Gm-Message-State: ALoCoQmlSkUsLU868/Ubic6Rnq04jalCgfmVEPEsE8W02R42eXSW6xFZAE6eeRPMONXPHqDe2jIu
X-Received: by 10.140.102.163 with SMTP id w32mr16403250qge.97.1403028436315;
        Tue, 17 Jun 2014 11:07:16 -0700 (PDT)
Received: from [172.17.3.150] ([38.104.173.198])
        by mx.google.com with ESMTPSA id k9sm28271362qaj.25.2014.06.17.11.07.14
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 17 Jun 2014 11:07:15 -0700 (PDT)
In-Reply-To: <xmqq8uovmn0d.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251932>

On Tue, 2014-06-17 at 11:03 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
>=20
> > Optimize check_refname_component using SSE2 on x86_64.
> >
> > git rev-parse HEAD is a good test-case for this, since it does almo=
st
> > nothing except parse refs.  For one particular repo with about 60k
> > refs, almost all packed, the timings are:
> >
> > Look up table: 29 ms
> > SSE2:          23 ms
> >
> > This cuts about 20% off of the runtime.
> >
> > Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz> suggested an SSE2 approac=
h to the
> > substring searches, which netted a speed boost over the SSE4.2 code=
 I
> > had initially written.
> >
> > Signed-off-by: David Turner <dturner@twitter.com>
> > ---
>=20
> When applied on top of your dde8a902 (refs.c: optimize
> check_refname_component(), 2014-06-03), this seems to fail t1402 for
> me.
>=20
> Test Summary Report
> -------------------
> t1402-check-ref-format.sh (Wstat: 256 Tests: 93 Failed: 9)
>   Failed tests:  28, 36, 38, 40, 63, 75, 77, 85-86
>   Non-zero exit status: 1
>=20
> #28 is the one that runs "check-ref-format heads/v@{ation".

Oops, I didn't even notice that test!  I was looking only at t5511!
Will fix.
