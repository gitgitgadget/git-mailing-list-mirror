From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsimport: rewrite to use cvsps 3.x to fix major bugs
Date: Fri, 11 Jan 2013 21:20:51 -0800
Message-ID: <7v62339du4.fsf@alter.siamese.dyndns.org>
References: <1357875152-19899-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 06:21:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TttWt-0004Gi-DH
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 06:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570Ab3ALFUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 00:20:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56252 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604Ab3ALFUy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 00:20:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39CA466DF;
	Sat, 12 Jan 2013 00:20:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bcwEZtNgI0NsqXYNr2CKkT7Wi7E=; b=YgHv+3
	GxeE32g/5c98hevCos/EjWmJoMSeDEp7+XlbXCs/A8AgdWee/o5ltD0CdgLuEpQN
	XX0ntoLMqG9llw+FodVXnPUDj1JuPhITIRGtwhRV/XRxFifsmudMFWWRCswyE8Ic
	+EzEVt9dbeQNvgFBR0dAJ97hpF2ltTmgYfw9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y7C+2pGsAQSz/qPSJthKIgkMGDy4FlY5
	Y5+P7+O6YshEVwI2QGhanE5ovtzwByJ5qd0GzrZyAC+UPzzam7Zdfwnei9QV11Sf
	hlQRP1LTZ8crjBjUNeOeDkaln2x4VxmAdSuBAd6u7F+gifpEcwdRmvxDEKgHpzWj
	8C6MpN1E+Gw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E22F66DE;
	Sat, 12 Jan 2013 00:20:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93F1566DD; Sat, 12 Jan 2013
 00:20:52 -0500 (EST)
In-Reply-To: <1357875152-19899-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Thu, 10 Jan 2013 19:32:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D56D9E3E-5C77-11E2-ADF3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213261>

I cloned git://gitorious.org/cvsps/cvsps.git and installed cvsps-3.7
at c2ce6cc (More fun with test loads, sigh.  Timezones suck.,
2013-01-09) earlier on my $PATH, and tried to run t96xx series with
this patch applied on top of Git 1.8.1.

The first thing I noticed was that all the tests were skipped.
A patch to t/lib-cvs.sh might be sufficient, 

--------------------- >8 -------------------------
diff --git a/t/lib-cvs.sh b/t/lib-cvs.sh
index 44263ad..423953f 100644
--- a/t/lib-cvs.sh
+++ b/t/lib-cvs.sh
@@ -17,6 +17,8 @@ cvsps_version=`cvsps -h 2>&1 | sed -ne 's/cvsps version //p'`
 case "$cvsps_version" in
 2.1 | 2.2*)
 	;;
+3.*)
+	;;
 '')
 	skip_all='skipping cvsimport tests, cvsps not found'
 	test_done
--------------------- 8< -------------------------

but I didn't check more than "now it seems not to skip them".
And here is what I got:

--------------------- >8 -------------------------
Test Summary Report
-------------------
t9600-cvsimport.sh              (Wstat: 256 Tests: 15 Failed: 9)
  Failed tests:  4-6, 8-9, 11-13, 15
  Non-zero exit status: 1
t9601-cvsimport-vendor-branch.sh (Wstat: 256 Tests: 9 Failed: 8)
  Failed tests:  1-4, 6-9
  Non-zero exit status: 1
t9602-cvsimport-branches-tags.sh (Wstat: 256 Tests: 11 Failed: 5)
  Failed tests:  1-3, 7, 9
  Non-zero exit status: 1
t9604-cvsimport-timestamps.sh   (Wstat: 256 Tests: 2 Failed: 2)
  Failed tests:  1-2
  Non-zero exit status: 1
Files=5, Tests=38,  5 wallclock secs ( 0.05 usr  0.01 sys +  0.49
  cusr  0.16 csys =  0.71 CPU)
Result: FAIL
--------------------- 8< -------------------------

A funny thing was that without cvsps-3.7 on $PATH (which means I am
getting distro packaged cvsps 2.1), I got identical errors.  Looking
at the log message, it seems that you meant to remove t960[123], so
perhaps the patch simply forgot to remove 9601 and 9602?

As neither test runs "git cvsimport" with -o/-m/-M options, ideally
we should be able to pass them with and without having cvsps-3.x.
Not passing them without cvsps-3.x would mean that the fallback mode
of rewritten cvsimport is not working as expected. Not passing them
with cvsps-3.x may mean the tests were expecting a wrong conversion
result, or they uncover bugs in the replacement cvsimport.

t9600 fails with "-a is no longer supported", even without having
cvsps-3.x on the $PATH (i.e. attempting to use the fallback).  I
wonder if this is an option the updated cvsimport would want to
simply ignore?

It is a way to tell the old cvsps/cvsimport to disable its
heuristics to ignore commits made within the last 10 minutes (this
is done in the hope of waiting for the per-file nature of CVS
commits to stabilize, IIUC); the user tells the command that he
knows that the CVS repository is now quiescent and it is safe to
import the whole thing.

If the updated cvsps can identify the changeset more reliably and it
no longer needs "-a" option, it may be more helpful to the users to
migrate their script if it allowed, warned and then ignored the
option.  It certainly would help sharing of this test script between
runs that use the old and new cvsps as backends.

t9601 (after resurrecting the t/t9601/cvsroot directory) fails in an
interesting way.

--------------------- >8 -------------------------
$ sh t9601-cvsimport-vendor-branch.sh -i -v
Initialized empty Git repository in /git/git.build/t/trash directory.t9601-cvsimport-vendor-branch/.git/
expecting success:

        git cvsimport -C module-git module

Traceback (most recent call last):
  File "/git/git.build/git-cvsimport", line 262, in <module>
    subprocess.check_output("cvsps -V 2>/dev/null", shell=True)
AttributeError: 'module' object has no attribute 'check_output'
not ok - 1 import a module with a vendor branch
--------------------- 8< -------------------------

Apparently, the copy of "subprocess.py" I have does not give us the
check_output thing:

--------------------- >8 -------------------------
$ python
Python 2.6.6 (r266:84292, Dec 26 2010, 22:31:48)
[GCC 4.4.5] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> import subprocess
>>> dir(subprocess)
['CalledProcessError', 'MAXFD', 'PIPE', 'Popen', 'STDOUT', '__all__', '__builtins__', '__doc__', '__file__', '__name__', '__package__', '_active', '_cleanup', '_demo_posix', '_demo_windows', '_eintr_retry_call', 'call', 'check_call', 'errno', 'fcntl', 'gc', 'list2cmdline', 'mswindows', 'os', 'pickle', 'select', 'signal', 'sys', 'traceback', 'types']
--------------------- 8< -------------------------

The story is the same for t9602 and t9603 (again after resurrecting
the necessary files).

http://docs.python.org/2/library/subprocess.html tells me that
check_output has first become available in 2.7.

So... does this mean that we now set the minimum required version of
Python to 2.7?  I dunno.
