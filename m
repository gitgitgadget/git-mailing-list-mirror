From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v12 03/13] ref-filter: introduce the ref_formatting_state stack machinery
Date: Thu, 20 Aug 2015 11:29:12 -0700
Message-ID: <xmqqio897r0n.fsf@gitster.dls.corp.google.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
	<1439923052-7373-4-git-send-email-Karthik.188@gmail.com>
	<vpqvbcb2uoi.fsf@anie.imag.fr>
	<CAOLa=ZTy8QO=H9g9g3SKU4HaG=qg71GidGuXKLXNgu7Su3FQ9A@mail.gmail.com>
	<vpqa8tn2sgy.fsf@anie.imag.fr>
	<CAOLa=ZSzXyQZJksNqyroU6Td+LG7ZRTF_WNNryusAGZxTYTmDg@mail.gmail.com>
	<CAOLa=ZRBTrWa5EEOxa-Rf+J+8DWP7gSGGEYaG75EsR=A1DofRA@mail.gmail.com>
	<vpq7foq1kpe.fsf@anie.imag.fr>
	<xmqqvbc97vpn.fsf@gitster.dls.corp.google.com>
	<vpqmvxlubbs.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 20 20:29:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSUaV-0002SB-2d
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 20:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbbHTS3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 14:29:15 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33692 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbbHTS3O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 14:29:14 -0400
Received: by pdrh1 with SMTP id h1so17270799pdr.0
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 11:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=TvZ88O0bZiSB+Z83fxbkQAjAhcvhv5WkVFbJLfnVNSQ=;
        b=iP+RpMNgpMSn/JXqsXoK3Vi3zJH5WXTaLk4LkzxfIJKvA9L9gH5hCTziMJqb9t7MDV
         +SCCih+DPCga3AYFeia8lunN7PTHOz5ZDm3VF1cH3oIHwa/ucOarkFcbES+D88VwwBxx
         r5t3qmBwYlHiyX3QnKDvJQdCtoT5RayhUGmtdunxt8dBMSTyFsBtz+XmsL26N6USGwWd
         1CjAOc1HBhWN1Cua3oe8OrGXBwR+bO92uPUHDnPG57fLiimdgKSiZ0uyRPSIL3Xww3uO
         HTKfPek0ssVunsAovE9UgGiQNvuBpCPGY/8VfTgWewbHfEyXn4kPToHs7wfF1Ti/fO8p
         3j1A==
X-Received: by 10.70.135.198 with SMTP id pu6mr8949455pdb.159.1440095353790;
        Thu, 20 Aug 2015 11:29:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:247b:3165:9cce:44a3])
        by smtp.gmail.com with ESMTPSA id fs13sm5139805pdb.29.2015.08.20.11.29.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Aug 2015 11:29:12 -0700 (PDT)
In-Reply-To: <vpqmvxlubbs.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	20 Aug 2015 19:19:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276258>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> So I think 'quote' should apply only to the top-level atoms in the
>> nested %(magic)...%(end) world.
>
> This is true in most cases, but I think there would also be use-cases
> where you would want the opposite, like:
>
> --format '
>     %(if:whatever)
>     echo %(refname)
>     %(end)
> '
>
> I'm not sure what's best, but if both can make sense, perhaps we should
> just keep the simplest to implement, i.e. the current behavior.

I am reasonably sure what's best, as --{shell,tcl,...} with --format
is my invention ;-)

The whole point of these "language specific quotes" to have
"--format" output to be an executable script is so that the user can
express control in that scripting language.  We must be able process
the examples in the message you are responding to, i.e. allowing
%(atom) and %(magic)...%(end) correctly assigned to a variable of
the target language.  If that implementation happens to also grok
your "%(if:whatever)...%(then)echo %(refname)%(end)" example in a
way you expect, that would be great, but if not, then I do not think
it is worth worrying about it.  On the other hand, a solution that
does not solve the primary use case is worthless, even if it is
simple to implement.

I do not think we deeply mind if we forbid use if %(if)...%(end)
when quoting is in use, if the current implementation too broken
beyond salvaging.  I however think that %(align:40)%(atom)%(end)
would want to be usable even with quoting, and I suspect that an
implementation that groks %(align) correctly would automatically
grok %(if), too.

So...
