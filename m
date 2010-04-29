From: Andreas Krey <a.krey@gmx.de>
Subject: git cherry(pick) dumps core
Date: Thu, 29 Apr 2010 21:11:50 +0200
Message-ID: <20100429191150.GA10526@inner.home.ulmdo.de>
References: <s2m76c5b8581004281238jf7179fffna7d757fee6ab4f10@mail.gmail.com> <r2s302ed1461004281249xd1b65e41l43fa7b639db7c97d@mail.gmail.com> <h2v76c5b8581004281259yfaca7abfz5a455ff8fd6cdc6b@mail.gmail.com> <o2j2cfc40321004281539j28fe44e0r5d029061e3e08b90@mail.gmail.com> <20100428233758.GA1654@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 01 02:59:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8138-0002jg-UA
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 02:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758637Ab0EAA7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 20:59:11 -0400
Received: from continuum.iocl.org ([213.146.114.200]:61028 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758600Ab0EAA7I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 20:59:08 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id o3TJBoY18380;
	Thu, 29 Apr 2010 21:11:50 +0200
Content-Disposition: inline
In-Reply-To: <20100428233758.GA1654@progeny.tock>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146071>

Hi,

I just have a case of git cherry-pick dieing with a core dump.
The directly offending lines are get_message() in buildin/revert.c:

	if ((out->reencoded_message = reencode_string(raw_message,
					git_commit_encoding, encoding)))
		out->message = out->reencoded_message;

	abbrev = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
	abbrev_len = strlen(abbrev);

	/* Find beginning and end of commit subject. */
	p = out->message;
	while (*p && (*p != '\n' || p[1] != '\n'))

and out->message is null at that point.

It looks like reencode_string is returning NULL,
and get_message can't quite cope with that.

This is in v1.7.1 (plus a few mods in git-daemon.c).

I suppose it is a failing of iconv_open, as this is
on sparc SunOS 5.9, but the reaction is a bit harsh.

Unfortunately the debugger is giving me strange
results, like:

434             if (!in_encoding)
(gdb) next
436             conv = iconv_open(out_encoding, in_encoding);
(gdb) print conv
$3 = 0x1003f8
(gdb) next
437             if (conv == (iconv_t) -1)
(gdb) print conv
$4 = 0x1003f8
(gdb) step
474     }

and the disasembly is just as counter-intuitive (with the branch targets).

Andreas
