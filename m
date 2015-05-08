From: evgeny <illumsoft.org@gmail.com>
Subject: t0005-signals.sh fails with ksh
Date: Fri, 8 May 2015 23:15:14 +0300
Message-ID: <31108626.20150508231514@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 08 22:09:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqoZy-0008M7-AJ
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 22:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbbEHUI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 16:08:58 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:36685 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932173AbbEHUI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 16:08:57 -0400
Received: by lbbqq2 with SMTP id qq2so60464379lbb.3
        for <git@vger.kernel.org>; Fri, 08 May 2015 13:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:message-id:to:subject:mime-version:content-type
         :content-transfer-encoding;
        bh=fwJEFXo8zm+nlcuT9JS5jIBAIXeasNxzxv9jxFPYxWY=;
        b=oQ/eHedYD26YfzlyJJDVtgW5YEJ/2imrwvaiYwM3V5JxlowpuED0XP/yRXWieUgupP
         K1+kYfAAa88EDLMuBMLB1Twa3KIzrr4noFDbZ5Tzh27luxRffK864Mdh9vyWL3kYbi93
         57C5BqjXNvmK07Pvd3XCNXvRMkvhySYXpkhRANlmDCDxGLbJVP3fDoZjLoehOL7jLZMk
         8gBebZpFW3puIh1o0yyfU2oVQnyK4yZjA7iSD17AHqE62bzJqq9Yz8+v9LZoqPdSbiXN
         hKZGT7JYfPd6pcyMB831T+bMk/+lWN0dRHen+n5nxHlWs4dO50iui80NQz+mfBMEr+en
         x12w==
X-Received: by 10.152.5.7 with SMTP id o7mr4079409lao.51.1431115736009;
        Fri, 08 May 2015 13:08:56 -0700 (PDT)
Received: from [10.0.2.15] (ppp78-37-187-150.pppoe.avangarddsl.ru. [78.37.187.150])
        by mx.google.com with ESMTPSA id do6sm1382373lac.19.2015.05.08.13.08.54
        for <git@vger.kernel.org>
        (version=TLSv1.1 cipher=RC4-SHA bits=128/128);
        Fri, 08 May 2015 13:08:55 -0700 (PDT)
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268657>

Hi,

Test t0005-signals.sh fails when I run 'make test' under ksh (on Solaris and on Linux)

$ ksh t0005-signals.sh -v
Initialized empty Git repository in /home/test/git/t/trash directory.t0005-signals/.git/
expecting success: 
        { test-sigchain >actual; ret=$?; } &&
        case "$ret" in
        143) true ;; # POSIX w/ SIGTERM=15
        271) true ;; # ksh w/ SIGTERM=15
          3) true ;; # Windows
          *) false ;;
        esac &&
        test_cmp expect actual

t0005-signals.sh[499]: eval: line 4: 23622: Terminated
ok 1 - sigchain works

expecting success: 
        # we use exec here to avoid any sub-shell interpretation
        # of the exit code
        git config alias.sigterm "!exec test-sigchain" &&
        test_expect_code 143 git sigterm

three
two
one
error: exec test-sigchain died of signal 15
ok 2 - signals are propagated using shell convention

expecting success: 
        test-genrandom foo 16384 >file &&
        git add file

ok 3 - create blob

expecting success: 
        OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
        test "$OUT" -eq 141

t0005-signals.sh[499]: eval: syntax error at line 4: `(' unmatched
Memory fault

I rather think there are two issues:
1. two adjacent parentheses
2. numeric constant (141) should be 269 for ksh, like there are two different 
constants in the test 'test-sigchain' in this file (in t0005-signals.sh)

'man ksh' reads:
  (list)
    Execute  list  in  a  separate environment.
    Note, that if two adjacent open parentheses are needed for nesting,
    a space must be inserted to avoid evaluation as an arithmetic command as
    described above.


-- 
Best regards,
 evgeny
