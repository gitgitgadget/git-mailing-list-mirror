From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH v3 0/5] pretty: format aliases
Date: Fri, 30 Apr 2010 20:35:23 +0100
Message-ID: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com, peff@peff.net,
	raa.lkml@gmail.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 30 21:38:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7w2x-0008Of-2J
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 21:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757526Ab0D3Tgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 15:36:41 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:64000 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932649Ab0D3Tfk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 15:35:40 -0400
Received: by wwb34 with SMTP id 34so446899wwb.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 12:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ljXgOVP/JUsWPjGTXR/PNa5cCmuK2KfzEis6ux0c9kU=;
        b=dhnURx7KNxK54MH9gbohSgqHhKcJYUsNPQYv8iStwBqwLSjiwaU92g5uygmxinPfLz
         QTB2CdVG4Vfk7MRc3bqX6EmGfn+xR/6LmeBiJT+cD2ud2uP/nL5RuPBH6Vhqj46NTLH7
         3rTbWDpljdPuhfxwScRvZ2R2NYQmLX53Z8+T8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Kl7iNqQtixwiFgN7/G8gA1KTJhgzNZBYVlz+yA+KW66dyh8L6tpIM8C3QMpBD/gGAA
         xyJYrKxTQmgQDjybl7ntk5TwDGtceHuYXiFaKtW30PLqKpRbr06XOkHrstiuYLAXNgWh
         Y3sdKTu16dglX2oJcUEVjNI9ATdpBBkXI2Yyc=
Received: by 10.216.183.143 with SMTP id q15mr1058063wem.208.1272656138503;
        Fri, 30 Apr 2010 12:35:38 -0700 (PDT)
Received: from localhost.localdomain (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id z3sm17896470wbs.4.2010.04.30.12.35.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Apr 2010 12:35:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.13.gbb0a0a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146054>

The following patch series adds the ability to configure aliases for
user-defined formats. The first two patches define new placeholders and
modify the output of existing placeholders to allow aliases to be more
consistent with the way built-in formats are handled. The third and
fourth patches add infrastructure for the ease of adding additional
formats, and infrastructure for defining format aliases, respectively.
The final patch adds support for defining format aliases via a config
option.

Regarding conditional colors:
There were a couple of places where I wasn't entirely sure about which
color setting I should be following, but I've tried to be consistent
throughout. It may be that I could have simply followed diffopt's color
option in all cases, in which case various modifications to show_log()
were entirely unnecessary. I'll await judgement at the hands of one who
groks those sections more than I do, but I think what I've done feels
correct.

Regarding pretty aliases:
My original goal was to make it possible to define all of the built-in
formats as built-in aliases to format strings, but complications
regarding how --parents and --decorate would be handled require further
thought and discussion. For example, we could simply make
"--format=%H --decorate" synonymous with "--format=%H%d", but I'm not
sure if that feels clean enough.

This is the third version of the patch. In the second version of the
patch, (Following feedback from Jeff King <peff@peff.net>), I realized
that the modification to the arguments of show_log() were unnecessary,
as they only made a difference within show-branch.c, which does not
accept a --format option in any case.

Thanks goes to Jeff King <peff@peff.net>,
Alex Riesen <raa.lkml@gmail.com>, and especially to
Jonathan Nieder <jrnieder@gmail.com>, who took time to do a full review
on the original patch. Most of their concerns have been addressed
through the new patches themselves, but of note:

	- Changes to %H need documentation/tests
	I disagree that a documentation change is needed, as it is my
	opinion that the documentation as-is implies the behavior these
	patches introduce. Tests have been added.

	- Documentation for %C?... needs clarification
	There seemed to be some confusion as to how the new syntax
	actually worked. I've split the documentation lines into
	separate entries for %C?... and %C?(...), to make it more
	clear that both %C?green and %C(white bold) are supported.

	- xstrdup is not necessary in config
	tested, and it seems that the strdup actually is needed. Ideally
	we would avoid an extra strdup of the format itself (which is
	rather needlessly copied to the static global *user_format), but
	the alternative would be adding an entirely separate codepath
	for "pre-specified" formats. It was an awful long way to go to
	avoid one extra strdup, so I just left the call to
	save_user_format in.

	- could the code which checks for format/tformat/etc be shared?
	probably, but I can't see a good way to do so.

	- (various confusion regarding the alias code)
	The alias code sucked. It's been ripped out and replaced with a
	much saner recursive model for find_commit_format. Thanks for
	steering me away from that mess.

	- setup_commit_formats() should be in setup_revisions()?
	While it might make the call-graph shorter, and would make
	some dependencies explicit, I think that keeping
	setup_commit_formats() in get_commit_format() makes more sense,
	by keeping "commit format" things together in one place. It's
	also less of a deviation from the code it was based on.

	- a = nothing, one = a, two = a. one is alias, two is not, why?
	Not sure. By the time I got to this one, the alias code had been
	completely changed and I couldn't reproduce. I'll declare this
	fixed.

Finally, after consensus among those discussing it, the config option
is now pretty.<name>, rather than format.pretty.<name>

Changes unrelated to any mailing-list discussion:

	- ignore aliases with the same name as built-in formats
	- fix a bug in the last patch where --pretty=full output fuller
	- fix a bug in the last patch where --abbrev-commit effected raw
	- be explicit that a redefined alias should overwrite the old

Lots of changes from v2 of the patchset, but overall I think a smaller
and cleaner patch.

Will Palmer (5):
  pretty: add conditional %C?colorname placeholders
  pretty: make %H/%h/etc respect --abbrev[-commit]
  pretty: make it easier to add new formats
  pretty: add infrastructure to allow format aliases
  pretty: add aliases for pretty formats

 Documentation/config.txt         |    9 ++
 Documentation/pretty-formats.txt |    9 ++-
 builtin/log.c                    |    2 +-
 builtin/rev-list.c               |    2 +
 builtin/shortlog.c               |    7 +-
 commit.h                         |    4 +-
 log-tree.c                       |    7 +-
 pretty.c                         |  228 +++++++++++++++++++++++++++++---------
 shortlog.h                       |    2 +-
 t/t4205-log-pretty-formats.sh    |  116 +++++++++++++++++++
 10 files changed, 327 insertions(+), 59 deletions(-)
 create mode 100755 t/t4205-log-pretty-formats.sh
