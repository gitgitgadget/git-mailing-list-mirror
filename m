From: Matthew Rothenberg <mrothenberg@gmail.com>
Subject: Efficient parsing of `status -z` output
Date: Sat, 7 Mar 2015 18:00:42 -0500
Message-ID: <CAMJduDuxBDoJ9_ETY8FCRoANf+taAS7-1acf5CFRGXDFyL72Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 00:01:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUNiZ-00036K-CT
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 00:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbbCGXBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 18:01:06 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:46235 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbbCGXBE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2015 18:01:04 -0500
Received: by igbhl2 with SMTP id hl2so12517059igb.5
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 15:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=hH5NrdfXZOAX8z320yl4rUF4D9JKekmQ4itPHzIuBs4=;
        b=ZuF4HyoC1pubavQev/hxUh1YWq9zaCSh7qAo4jXhfJOeZpQ98Mx1zT5QXFcSN2nLlP
         KhQokzITbxVLKvqzMuOfwii/lAVDB/0twQePqVXQuFjN1NKlwQY39etmq/TQ/M8UT7vi
         1hYvllHGfoLCRB7HNzr0tJHF1mugmMhvPJq3o335Rs6lNG/FuGVfm8pB+lC+gGJgseyg
         KET99Zu4irwvHw/xou6zibjO/DIIlNl9P/jrKZaAaC7TytU+J/+Lax8bkFWM1P+VhmIm
         ajCgjqSb7zusOjFMbYZfWHXTyte5V76174taKSAvCfOL6aui4BFADZFhdGnSvKV4Yx48
         PGDg==
X-Received: by 10.42.216.145 with SMTP id hi17mr17749887icb.63.1425769263183;
 Sat, 07 Mar 2015 15:01:03 -0800 (PST)
Received: by 10.36.25.74 with HTTP; Sat, 7 Mar 2015 15:00:42 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265008>

I've been working on a utility that parses the output of `git status
--porcelain` as a fundamental part of its operation.

Since I would like for this tool to be as robust as possible (and
cross-platform compatibility is a goal), I am currently trying to
migrate it from parsing the output of `--porcelain` to using the
output of `-z`, to quote from the documentation:

    > There is also an alternate -z format recommended for machine parsing. In
    > that format, the status field is the same, but some other things change.
    > First, the -> is omitted from rename entries and the field order is
    > reversed (e.g from -> to becomes to from). Second, a NUL (ASCII 0) follows
    > each filename, replacing space as a field separator and the terminating
    > newline (but a space still separates the status field from the first
    > filename). Third, filenames containing special characters are not
    > specially formatted; no quoting or backslash-escaping is performed.

I am encountering some significant issues with using this because of
one detail.  In particular, parsing output using NUL as *both* the
entry terminator and the filename separator for entries that contain
multiple files is problematic. Because of this, one cannot know in
advance how many NULs to read from the buffer until considering an
entry to be in memory for parsing.

There are two workarounds I've considered:

 1. Reading the *entire* buffer into memory, and then using a regular
expression (yikes) to split the entries. This is something I would
obviously like to avoid for performance reasons.

 2. Read from buffer until the first NUL, parse the entry status
codes, and if the entry status code represents a status that *should*
have multiple filenames, read from buffer until a second NUL is found,
and then reparse that entry with both filenames. The issues I see with
this approach:
   a.) One has to know exactly which status code combinations will end
up with two filenames, and this list has to be exhaustive. As far as I
can tell, there is no canonical documentation for this?
   b.) It seems a bit brittle, because if the logic from the above is
wrong and we miss an extended entry or ask for one when it doesn't
exist we will leave the buffer an essentially corrupt state for future
reads.

My understanding is the goal of `-z` is to make machine parsing status
from a binary stream *more* reliable, so perhaps (likely!) I am
missing something obvious?

Thanks for any assistance!
