From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 0/2] Let merge-file write out conflict markers with correct
 EOLs
Date: Tue, 26 Jan 2016 15:42:06 +0100 (CET)
Message-ID: <cover.1453819314.git.johannes.schindelin@gmx.de>
References: <cover.1453709205.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:42:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4pE-0008Iq-Uz
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966298AbcAZOm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:42:28 -0500
Received: from mout.gmx.net ([212.227.15.19]:63215 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966258AbcAZOmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:42:25 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LrvBu-1ZyCS71GiE-013hKV; Tue, 26 Jan 2016 15:42:09
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453709205.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Nsnr7DIvhCjVo11UUG/X82iRkYerIttDGeIbanxfG8hxYaukEgy
 cTiZl5tc3+bmZEF6t76X19jJlFJ6c4qQhtMHlYcOZ1OCgYb9uRLN0mpxrKiE6WVtXDhFVHM
 PIQ3FTDnmA/jApES/+VDJtn25jCAWQ43kj+efz6/gudfmMbWlrHyAgc5B4tpSo6p2V3l/x7
 Wg/8fm/Cw6CDdH0mULRLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qc1I8l9H1h0=:1W21nCVfFWMTwmxgMrNydM
 BBQ7+rS1NYgUiRYNiugt3kBrG0JnkiJtEGDDlNmt1tJA+JnpabZwMslB1fLuoYz7+7YcXSGoB
 lLSQAyCiLpNt6OwX/ROizenLt09XzoH1kU7DnS8mZY3nAH5DjS2jDpuCJhKf1sGhygkGItaU1
 Ac1euvHl2l1i781gv5TmoUIaEr/sIRdjYU/UQgkARHibKN+3m4tEWZjZJ8P/b/qvwdW1zKFlO
 QowvFVgF+2wtd/UTxCthimlRkftCsk/Py01XSsrYkQ0D6q3su7ffm9+yWqEyMeoJ5KNrMZqFE
 u/P2PPoQAXp9rzZBI+5NCP58G6wgGJb2ME74uStFepyXwmFMUw3tAST6OGFtxkYizHlcIzm0S
 Btoks4/J7ZYP0ygiGsEtifJ3IVrIRvrvwhUCcbbMvLUVyv2IJcmbdq20l2sNRgiMrkEEwlayz
 sW0GeA7/N00ghJghQJhizOL0ZGs+IhymBHcmJsMDpaNljPIFq6clgclkH6xVRgjUZtblmubA2
 iyhqGIXyTruRXACG3sN8IfDbb6RDbeW76a0+Z3TjjpOd0psgsQbJL8uFKP4t9gLUmXv8dv1SW
 1pXXh1fqVNkxATiKIWXh8ry6cywqpwNJ1d4glahAg58iHRINmQ/XdrURtK3fh0hKHWcj/MJKy
 5ByGL4oltGnRNEyipWo3LeZYMcS7gOWm5c2zzLhqNWOZPIRfgFwpGzrp5hX2IZx3hoDz+nyOe
 z53VDR/3nOu/UyaLqQLXdUcwBPwdTer05F8J8ZdN1lr/DrboT+oR02MXUzEnBg2wnlfexCbq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284837>

The original patch was sent by Beat Bolli in
http://thread.gmane.org/gmane.comp.version-control.git/281600

My suggestion to extend it to respect gitattributes led to
changes that broke the original patch. And they were misguided
to begin with (see below).

Since there have been a couple of "What's cooking" mails
containing unheard calls for updates on this patch, I took it
on myself to fix things.

Junio's comment that we might look at blobs containing CR/LF
line endings made me rethink the entire approach, and I am now
convinced that we need to abandon the entire idea to make the
conflict markers depend on config settings or attributes:
after all, I introduced `git merge-file` as a replacement for
GNU merge that can be used *outside* of any repository, by design.

The crucial idea hit me yesterday when I took a step back: all
we need to do is to ensure that the end-of-line style is matched
when *all* input files are LF-only, or when they are all CR/LF.
In all other cases, we have mixed line endings anyway.

And to do that, it is sufficient to look at *one single line
ending* in the context. Technically, it does not even have to be
the context, but the first line endings of the first file would
be enough, however it is so much more pleasant if the conflict
marker's eol matches the one of the preceding line.

To prevent my future self from repeating mistakes, I added a
little bit of background to the first commit message.

Triggered by a comment by Junio, I realized that a second patch is
needed: we need to make sure that the conflicting sections are also
augmented by the appropriate line endings if they lack any.

The interdiff vs v3 is empty because I only pulled a refactoring
from 2/2 into 1/2 already, making the series easier to read.


Johannes Schindelin (2):
  merge-file: let conflict markers match end-of-line style of the
    context
  merge-file: ensure that conflict sections match eol style

 t/t6023-merge-file.sh | 13 +++++++
 xdiff/xmerge.c        | 98 +++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 93 insertions(+), 18 deletions(-)

-- 
2.7.0.windows.1.7.g55a05c8
