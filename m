From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: jn/apply-filename-with-sp (Re: What's cooking in git.git (Aug
 2010, #02; Wed, 11))
Date: Fri, 13 Aug 2010 00:59:05 +0000
Message-ID: <AANLkTimobYCq2fBzF3j2ukCGhMEDVmMBN=7g3rURcqo7@mail.gmail.com>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
	<4C63BD9B.6000608@viscovery.net>
	<20100812224044.GK2029@burratino>
	<7v1va3pgio.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Greg Brockman <gdb@mit.edu>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 02:59:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjicN-0007dn-S3
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 02:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757408Ab0HMA7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 20:59:08 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37538 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124Ab0HMA7H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 20:59:07 -0400
Received: by ywh1 with SMTP id 1so664258ywh.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 17:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=+MOHc5l6Sz4aPw38LbwRQzGBIi4ABRgW/beVsR5hR6Q=;
        b=tqP+yHryz3YBZe6y2vYiHl+HqPS7C4J6uBdBoJR41dykjqO1VxC2FxOXQx0cMrEMAL
         sN4b07ZVSb6ybt9WVVseV0xI5Aj1ygHIBwUcPW9z2wZ/njJ+pNV1Gr4Y98Q4oEosxHQ0
         WXTWjJL1EePbPUXSynK1t2HCmvWuaJqT42AUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=NYLF3NTRXhyQEkoLaHO6Bdop5fBQ/pWlpt4NW5WPTpPgAVezaW1zYs+wzgkHsL7IHt
         ZmxGNNX+f8OdjT72xFK0OWkz2E1L0a/7tLPOmjTk0lf5Pb3KxWrxgGYtXDldxk7u7DFB
         T2PaO1JL2kYDZUY3oQlSief6odAvqduQT/WmU=
Received: by 10.231.15.133 with SMTP id k5mr909894iba.84.1281661145939; Thu,
 12 Aug 2010 17:59:05 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Thu, 12 Aug 2010 17:59:05 -0700 (PDT)
In-Reply-To: <7v1va3pgio.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153448>

On Thu, Aug 12, 2010 at 23:17, Junio C Hamano <gitster@pobox.com> wrote:

> The file based caching of the above wouldn't work well under "make -j";
> without it, we can still have a prerequisite checked only once per a test
> script run, which is not worse than the current situation (and it would
> even save cycles if a test does not check for a particular prereq,
> e.g. SYMLINKS, that is always checked in test-lib).

I think that's being a little too clever for such a small part of the
test suite, better to just stick specialized checks like these into
e.g. lib-check-fs.sh, which those tests can then source.

Or just leave it as-is, trying to create a few files is a negligible
part of the test execution time, most of the tests are doing a lot
mork work than just trying to create a symlink or a file with a funny
name.

Anyway, a simpler implementation of lazy-loading would be to have
e.g. t/lib-prereq/FUNNYNAMES.sh. test_have_prereq could then just
do:

    lazy="$TEST_DIRECTORY/lib-prereq/$prereq.sh"
    test -f $lazy && . $lazy # TODO: Don't load this if we've done it already
    case $satisfied in ...

Or something like that, that'd eliminate the need for file creation,
since prereq labels would map directly to filenames, and there could
be an internal "${prereq}_FOO" variable checking if it was loaded
already.
