From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 0/3] teaching log's --glob=<glob> and friends to git
 shortlog
Date: Thu, 21 Apr 2011 05:22:41 -0500
Message-ID: <20110421102241.GA16185@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pierre Habouzit <madcoder@madism.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 12:22:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCr2D-00035M-Ph
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 12:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179Ab1DUKWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 06:22:49 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47692 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab1DUKWs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 06:22:48 -0400
Received: by iyb14 with SMTP id 14so1280099iyb.19
        for <git@vger.kernel.org>; Thu, 21 Apr 2011 03:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=bly7inK45ZEWOWv+jgdd0xt5Qwko95Yaz+zBroHolm4=;
        b=Gz/NsTWWEFwyaDbRRmz3Wgf1Qo9pmL+BdxHvCgwfrfblwYEfgUQwvRPF5rsyS+kyM8
         MznImE0HtLU/DDQhn6PgvFurJy0aFTef/BSZzr0ZT0+M2Y3d6QzTXlc2QLart/GLNGI2
         WBhqD/hECWIzBn368KPY0LMmwv3U4EgapoXUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=I0WeoK7cb6bdCH1yY59g1adyWxpSKqc8bx078hVwG0LOaXaFNbCgQ7xXct6LMqL9PF
         A6DOT5yxZgSh2FLfs92JClNMig9ZnREqTXTFnCa/iBkKLo8+HH0Wf1zzc8d+JTKkC5pH
         qZCZAeDxAba2WlcyDE99hGjm3CM0KVaKY1Bl8=
Received: by 10.231.68.202 with SMTP id w10mr6616742ibi.63.1303381367867;
        Thu, 21 Apr 2011 03:22:47 -0700 (PDT)
Received: from elie (adsl-69-209-64-141.dsl.chcgil.ameritech.net [69.209.64.141])
        by mx.google.com with ESMTPS id d9sm721273ibb.19.2011.04.21.03.22.45
        (version=SSLv3 cipher=OTHER);
        Thu, 21 Apr 2011 03:22:46 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171897>

Hi,

While looking over the setup_revisions code to work on an interesting
request from Josh Triplett[1] (that happens to coincide with a
longstanding wish of my own), I got distracted by a few things.  The
nominal subject of this series is to teach "git shortlog" to handle
commands like

	git shortlog --glob=remotes/charon/notes/*

Patch 1 makes the code clearer about something I had been confused
by for a long time --- the --no-walk option invented for "git show"'s
benefit has global effect.  So tricks like[2]

	git rev-list ^HEAD --no-walk commit1 commit2 ...

to list branches not contained in HEAD will not work, alas.

Patch 2 unindents the code a little.

Patch 3 is the title piece --- it adds --glob=, --tag=, and so forth
to the whitelist in handle_revision_opt so commands like "git
shortlog" that parse revision listing options in two stages will queue
them correctly.

While working on this I was struck by how close the setup_revisions
code has been to parseoptification all these years.  Maybe some
weekend.

Thoughts and improvements welcome, of course.

Jonathan Nieder (3):
  revisions: clarify handling of --no-walk and --do-walk
  revisions: split out handle_revision_pseudo_opt function
  revisions: allow --glob and friends in parse_options-enabled commands

 revision.c               |  138 ++++++++++++++++++++++++----------------------
 t/t6018-rev-list-glob.sh |   50 +++++++++++++++++
 2 files changed, 122 insertions(+), 66 deletions(-)

[1] http://bugs.debian.org/621601
[2] http://thread.gmane.org/gmane.comp.version-control.git/138109/focus=138124
