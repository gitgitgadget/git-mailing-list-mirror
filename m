From: BJ Hargrave <bj@bjhargrave.com>
Subject: Re: [ANNOUNCE] Git 1.7.6.4
Date: Fri, 23 Sep 2011 23:33:23 -0400
Message-ID: <4850EB43-5CC7-4D33-90A8-1EDEE16ECAB7@bjhargrave.com>
References: <7vlitesucu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 24 05:33:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7Ize-0007Oj-CY
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 05:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302Ab1IXDd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 23:33:27 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34292 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166Ab1IXDd1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2011 23:33:27 -0400
Received: by gxk6 with SMTP id 6so3139487gxk.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 20:33:26 -0700 (PDT)
Received: by 10.150.166.1 with SMTP id o1mr4088574ybe.73.1316835206574;
        Fri, 23 Sep 2011 20:33:26 -0700 (PDT)
Received: from macbookpro2.hargrave.local (106.27.205.68.cfl.res.rr.com. [68.205.27.106])
        by mx.google.com with ESMTPS id u4sm10362636ane.21.2011.09.23.20.33.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Sep 2011 20:33:25 -0700 (PDT)
In-Reply-To: <7vlitesucu.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182017>

On Sep 23, 2011, at 19:37 , Junio C Hamano wrote:
> * "git check-ref-format --print" used to parrot a candidate string that
>   began with a slash (e.g. /refs/heads/master) without stripping it, to make
>   the result a suitably normalized string the caller can append to "$GIT_DIR/".

When building 1.7.6.4 on my RHEL 4 system, it failed t1402-check-ref-format.sh:

 not ok - 19 ref name 'heads/foo' is not valid

I bisected and found that commit f3738c1ce9193a4bf45ba1a3ea67d0cf32da0257 introduced the issue. 

The test

 invalid_ref "$(printf 'heads/foo\177')"

was added to t1402-check-ref-format.sh. However sh on my RHEL 4 system does not handle the DEL (\177) character well in double quoted strings.

sh-3.00$ echo $(printf 'hello\177') | hexdump -C
00000000  68 65 6c 6c 6f 7f 0a                              |hello..|
00000007
sh-3.00$ echo "$(printf 'hello\177')" | hexdump -C
00000000  68 65 6c 6c 6f 0a                                 |hello.|
00000006

The double quotes cause the DEL (\177) character to be discarded.

Can this test be rewritten to avoid this apparent bug in sh on RHEL 4?

-- 

BJ Hargrave
