From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] t: Add test for cloning from ref namespace
Date: Fri, 05 Jun 2015 09:22:18 -0700
Message-ID: <xmqq7frit9ad.fsf@gitster.dls.corp.google.com>
References: <1433193883-11577-1-git-send-email-johannes@kyriasis.com>
	<1433513531-13423-1-git-send-email-johannes@kyriasis.com>
	<1433513531-13423-3-git-send-email-johannes@kyriasis.com>
	<xmqqk2vitbjh.fsf@gitster.dls.corp.google.com>
	<20150605161225.GA23368@leeloo.kyriasis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes =?utf-8?Q?L=C3=B6thberg?= <johannes@kyriasis.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:22:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0uO2-0001ke-Cf
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 18:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbbFEQWW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2015 12:22:22 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38169 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbbFEQWV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 12:22:21 -0400
Received: by igblz2 with SMTP id lz2so18359547igb.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 09:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=gSyJMkm3glc6hI+eU5Fyp4hbG4qdKzXPJwq+4OmOG2w=;
        b=J8ni9umEByQtbZx1r+fcJNw8FgK7aDBU+5W/CXiQmbrjWS8Vs+QkcswB7IboFNswY6
         5NccjwNcWhOFZf6XQ8sreHGPLeyUyPKxzJiP/sjTZD0C8mKlGABkv489pqyESkeVQo9y
         REah+MV/C8xsSeTHoln5bIVbA16Wb3N52JYf1OQRU0CovZfaqlBVHQmj0HVlWiQrZtS7
         jNpmTX7+6chhavVhJxhjObnI/N92+6mr9GilWKna9N0rxj8r5ipg6T6uNCk/UPQ/6t77
         teWrd5brkbshbARejo0DiJmDB50LRnDfCaixID4x2fn02RbbB+eZWUq7u62uNLBcTwoq
         uLEA==
X-Received: by 10.42.175.74 with SMTP id az10mr6403149icb.55.1433521340588;
        Fri, 05 Jun 2015 09:22:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8c50:e66f:fc40:1825])
        by mx.google.com with ESMTPSA id o2sm1601437igr.9.2015.06.05.09.22.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jun 2015 09:22:19 -0700 (PDT)
In-Reply-To: <20150605161225.GA23368@leeloo.kyriasis.com> ("Johannes
	=?utf-8?Q?L=C3=B6thberg=22's?= message of "Fri, 5 Jun 2015 18:12:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270847>

Johannes L=C3=B6thberg <johannes@kyriasis.com> writes:

> Hmm, it seems that git-rev-parse doesn't handle GIT_NAMESPACE yet, so
> can't check it for the namespaced push right now. Not sure if I can
> fix that myself though.

I do not see a need for rev-parse to pay attention to GIT_NAMESPACE
at all, though.

The destination that accepts the push with the enviornment variable,
i.e. your ../bare repository after this:

+		git commit -m "commit two"
+		GIT_NAMESPACE=3Dnew_namespace git push ../bare master

must be saving the result somewhere in ../bare/, and that is what
you want to check (and also no refs are affected outside that
hierarchy).

So perhaps along the lines of

        echo $(git rev-parse master) commit \
        	refs/namespaces/new_namespace/refs/heads/master >expect &&
	git -C ../bare for-each-ref refs/namespaces/ >actual &&
	test_cmp expect actual

or something?  You would want to also check that other refs are not
molested, so

	(
        	echo $(git rev-parse master^) commit \
                	refs/heads/master &&
	        echo $(git rev-parse master) commit \
	        	refs/namespaces/new_namespace/refs/heads/master
	) >expect &&
	git -C ../bare for-each-ref >actual &&
	test_cmp expect actual

might be a more appropriate test.
