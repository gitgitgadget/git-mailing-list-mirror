From: Stephen Boyd <bebarino@gmail.com>
Subject: parse-options: ambiguous LASTARG_DEFAULT and OPTARG
Date: Thu, 04 Jun 2009 22:43:14 -0700
Message-ID: <4A28B072.8030006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 07:43:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCSDI-0008EY-TF
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 07:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871AbZFEFnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 01:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754815AbZFEFnS
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 01:43:18 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:29372 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777AbZFEFnS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 01:43:18 -0400
Received: by rv-out-0506.google.com with SMTP id f9so583986rvb.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2009 22:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=QTN4V+7x/VPK1K6BCePd6AwG3JWZpejmMYYYfz2cAmw=;
        b=wVH0zmwB3IJ6mA9Mcacp6snk68fkQKioWkCd6m+2cHqGqNTSJOBOOIu/lJEISw/eHS
         +rZyjK9sCCgjmKXRqLgvCKMYuhd7y+i0iVQEYPEY9wY9+mIa66sArk+GVSUdjfutI41/
         BR2/emUJ1y8Ypa7VaeGrgVy/b+o0CzIHGdokE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=ZGba1pCCBrugtmoaS05RvbTLTx5NPofgW7QSBYz+UmZz/1prTcoeUKLsHa9ntweFxH
         eSqa0UywDU5oTXSNfp/b18f3ifMvFBREK7VgaeNeayreGXvDO3ztvlbCLXF3JHny4KbP
         XjHAikkJb1onQCeqrT1biQsZMkK173okb4MnY=
Received: by 10.141.154.8 with SMTP id g8mr125416rvo.8.1244180598423;
        Thu, 04 Jun 2009 22:43:18 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id g22sm5972650rvb.56.2009.06.04.22.43.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 22:43:17 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120742>

Hi,

This in builtin-branch.c

        {
		OPTION_CALLBACK, 0, "merged", &merge_filter_ref,
		"commit", "print only merged branches",
		PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG,
		opt_parse_merge_filter, (intptr_t) "HEAD",
	},

and the usage message for "git-branch -h" will print out

    --merged <commit>

when I'm expecting

    --merged[=<commit>]

This is because the PARSE_OPT_OPTARG flag is not used. Is this correct?
The default value is still set correctly in some cases, but become
ambiguous in other cases. Take this for example

    $ git branch --merged --verbose
    fatal: malformed object name --verbose

but

    $ git branch --verbose --merged

works fine.

The simple fix is to just add PARSE_OPT_OPTARG to the flags, and fix a
test or two. But I'm wondering if doing that will become problematic for
end-users. Essentially you can no longer do git branch --merged master,
you must do git branch --merged=master.
