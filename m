From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] add: allow configurations to be overriden by command
 line
Date: Thu, 18 Jun 2009 11:58:59 -0700
Message-ID: <4A3A8E73.1010807@gmail.com>
References: <1245316674-32377-1-git-send-email-bebarino@gmail.com>	<7vfxdxxzps.fsf@alter.siamese.dyndns.org> <4A3A8412.7070705@gmail.com> <7veitho0gu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 20:59:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHMpR-0002iY-C2
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 20:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbZFRS7C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 14:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753537AbZFRS7B
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 14:59:01 -0400
Received: from mail-px0-f189.google.com ([209.85.216.189]:52800 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbZFRS7A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 14:59:00 -0400
Received: by pxi27 with SMTP id 27so1278980pxi.33
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 11:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Sg6nb+S4rQA9Q3vTkA8m5lk6ekkG4r6wXjoM/RnynO8=;
        b=gPhCbqzKGtVtobul90/bSDFZWYvZV0mdKgsyTC/RbtCI2oqAwJFJcnDOwhQ6ETXAtx
         ggb6oNv8cJIns0pYgiLkdP186OvGZgtd+HuPv4wEWMR6gw2QHqf2pC3k9kxN6Qd1fPld
         WExpFw7Epl0giwW3+SByiQKinUpK2EPxPI4KE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Y1hCCowpM1qRWb/Dty6oGFZktpCZmvt8oDDlMyH+T0gCfpA2DcGz3NbdJNB/2KDnCM
         8VncxPqYhHymvEy5Pu/TM/kkLtzkgkWBS/jz0RYazNMLV2Igzd4xmS6R//gKxI5y9k0H
         oGSuZyxNo8l61SpsVS/ivqgavRQWbGKqkGJbs=
Received: by 10.142.200.3 with SMTP id x3mr1084610wff.168.1245351543159;
        Thu, 18 Jun 2009 11:59:03 -0700 (PDT)
Received: from ?192.168.1.5? (user-0c9haco.cable.mindspring.com [24.152.169.152])
        by mx.google.com with ESMTPS id 22sm243464wfd.19.2009.06.18.11.59.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Jun 2009 11:59:01 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <7veitho0gu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121867>

Junio C Hamano wrote:
> Why do you need POSIXPERM for this?
>   

I copied a previous test and it was doing chmod 0 foo2. This test is
actually depending on that earlier test which is probably bad style,
sorry. Here's a more insulated version.

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 6ce8256..66bdc24 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -221,6 +221,19 @@ test_expect_success POSIXPERM 'git add (add.ignore-errors = false)' '
        test_must_fail git add --verbose . &&
        ! ( git ls-files foo1 | grep foo1 )
 '
+rm -f foo2
+
+test_expect_success POSIXPERM '--no-ignore-errors overrides config' '
+       git config add.ignore-errors 1 &&
+       git reset --hard &&
+       date >foo1 &&
+       date >foo2 &&
+       chmod 0 foo2 &&
+       test_must_fail git add --verbose --no-ignore-errors . &&
+       ! ( git ls-files foo1 | grep foo1 ) &&
+       git config add.ignore-errors 0
+'
+rm -f foo2
 
 test_expect_success BSLASHPSPEC "git add 'fo\\[ou\\]bar' ignores foobar" '
        git reset --hard &&
