From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [ANNOUNCE] git related v0.3
Date: Sun, 18 May 2014 19:36:51 -0500
Message-ID: <537952234b691_10da88d308d8@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 19 02:48:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmBkH-0005yI-C9
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 02:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbaESAr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 20:47:58 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:41729 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbaESAr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 20:47:57 -0400
Received: by mail-ob0-f178.google.com with SMTP id va2so5382305obc.23
        for <git@vger.kernel.org>; Sun, 18 May 2014 17:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:subject:mime-version:content-type
         :content-transfer-encoding;
        bh=2YHUPNBdo+oBo37/0sOmB4ZsBp21FOQof+DhwywahF0=;
        b=TMxJbIPbmleCQGM78MVVuncyoLsJceg7sjq7Pzk7Nsd6GDw6f7R5rzWCFplCI3KGCz
         YCk2PcqNb6LiyqdvMxbqx4AVT9JvVNgZzc2fH45VRfo7ew7Omb9RGEYuLR9dmnB9tJXJ
         odIYrfu6tIua4SCePICiNMGSRw/jjeR2DnUOJhuIUt1X4ZIvUl1gxxkfD4m0jMF6ZQH5
         qlsi7+zleI5ZSUkMa5WmBJo+OC5/rb/Ih2pVLUbr8qjHbVqK1yKUlNnC1cWACoN8hMt6
         /T39SJ/qC9LWisySAa4+0IIRLsGEoxCd3fNdgBpiD6G0BQWoeNT3AuaRtRqT5sTtzPkn
         GF8w==
X-Received: by 10.60.15.38 with SMTP id u6mr32226308oec.26.1400460477002;
        Sun, 18 May 2014 17:47:57 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id r3sm29015904obi.23.2014.05.18.17.47.55
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 May 2014 17:47:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249555>

Hi,

This tool finds people that might be interested in a patch, by going
back through the history for each single hunk modified, and finding
people that reviewed, acknowledged, signed, or authored the code the
patch is modifying.

It does this by running `git blame` incrementally on each hunk, and
finding the relevant commit message. After gathering all the relevant
people, it groups them to show what exactly was their role when the
participated in the development of the relevant commit, and on how many
relevant commits they participated. They are only displayed if they pass
a minimum threshold of participation.

It is similar the the `git contacts` tool in the contrib area, which is a
rewrite of this tool, except that `git contacts` does the absolute minimum;
`git related` is way superior in every way.

For example:

------------
% git related master..fc/transport/improv
  Junio C Hamano <gitster@pobox.com> (signer: 90%, author: 5%)
  Felipe Contreras <felipe.contreras@gmail.com> (author: 25%, reviewer: 2%)
  Sverre Rabbelier <srabbelier@gmail.com> (author: 17%, acker: 2%, signer: 7%)
  Jeff King <peff@peff.net> (acker: 17%, author: 10%)
  Shawn O. Pearce <spearce@spearce.org> (author: 5%, signer: 2%, cced: 2%)
  Elijah Newren <newren@gmail.com> (author: 10%)
------------

In addition, it has an option to output the list of commits, instead of the
contributors, which allows you to easily find out the previous changes to the
lines your patches modify.

------------
% git related -c master..fc/transport/improv
  99d9ec0 Merge branch 'fc/transport-helper-no-refspec'
  67c9c78 transport-helper: barf when user tries old:new
  0460ed2 documentation: trivial style cleanups
  126aac5 transport-helper: fix remote helper namespace regression
  21610d8 transport-helper: clarify pushing without refspecs
  a93b4a0 transport-helper: warn when refspec is not used
  664059f transport-helper: update remote helper namespace
  c4458ec fast-export: Allow pruned-references in mark file
  ...
------------

Moreover, when sending patches for review, you can configure `git send-email`
to use `git related` to find relevant people that should be Cc'ed:

------------
% git send-email --cc-cmd='git related' *.patch
------------

Compared to `git related`, `git contacts` has the following limitations:

 1) Doesn't show the amount of involvement
 2) Doesn't show the kind of involvement (reviewer, author) nor
    does it group people by their email address
 3) Doesn't have the option to show the commit themselves
 4) Doesn't have any options at all (--since, --min-percent)

Cheers.

https://github.com/felipec/git-related

Changes since v0.1:

 * Fix compatibility with older versions
 * Add -clong option
 * Add manpage
 * Improve performance by grouping line ranges

Felipe Contreras (12):
      Fix compatibility with Ruby 1.9
      Add support for Ruby 1.8
      Fix popen workaround
      Refactor blame parsing
      Pass multiple ranges to `git blame`
      test: add gitingnore file
      Add -clong option
      Add manpage
      build: add installation stuff
      readme: trivial updates
      test: add test-lib helper
      travis: initial configuration

-- 
Felipe Contreras
