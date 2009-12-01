From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH 0/8] Git remote helpers to implement smart transports.
Date: Tue,  1 Dec 2009 15:57:10 +0200
Message-ID: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 15:03:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFTKP-0006lX-CJ
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 15:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbZLAODY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 09:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753108AbZLAODX
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 09:03:23 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:34981 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbZLAODX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 09:03:23 -0500
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Dec 2009 09:03:23 EST
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id D03EE13BEC5
	for <git@vger.kernel.org>; Tue,  1 Dec 2009 15:57:22 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A0450BCD007; Tue, 01 Dec 2009 15:57:22 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 06D3E1C6392
	for <git@vger.kernel.org>; Tue,  1 Dec 2009 15:57:21 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc0.64.g5593e
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134203>

This series implements extensions to remote helpers for carrying smary
transports. It is against next, because master doesn't contain necressary
patches (the allow specifying remote helper in url one).

First patch reworks URL handling so that unknown protocols are passed
to remote helpers. This allows having remote helpers implement git
transports without duplicating the protocol part.

Second patch refactors git transport option parsing to split smart
transport option to own structure and keep this structure up to date
with encountered options. This is needed if transport turns out to
be smart transport.

Third patch adds capabilty to have git smart transport code take
over connection, replacing "layer 7" with git smart transport protocols.

Fourth patch actually adds the extensions to external transport code to
allow helpers signal that transport should be taken over (become smart
transport).

Fifth patch extends 'git archive' to allow snapshotting off any transport
that uses git smart transport code, not just file://, git:// and ssh://

Sixth patch removes special casing of http, https and ftp. And while
at it, adds ftps, since CURL supports it.

Seventh patch adds debug mode for remote helpers. Might be useful for
debugging deadlocks by showing command traffic between git executable
and remote helper.

Eighth patch adds support for remote helper to signal that it requires
some capability and have git complain if it doesn't know it.


Misc remarks:

Underlying network link is assumed to be full-duplex since most of the
time if the underlying link isn't HTTP, it will be full-duplex (most of the
time even TCP).

Simplest deadlock-free buffering is just to read incoming pipe from git
when there's no data to send to remote end. This gives adequate performance
in all cases except when sending large initial ref adverts (and those are 
ended by flush anyway, so those can be safely buffered). So no extensions
to add missing flushes are needed.

Ilari Liusvaara (8):
  Pass unknown protocols to external protocol handlers
  Refactor git transport options parsing
  Support taking over transports
  Support remote helpers implementing smart transports
  Support remote archive from external protocol helpers
  Remove special casing of http, https and ftp
  Add remote helper debug mode
  Support mandatory capabilities

 .gitignore                           |    5 +-
 Documentation/git-remote-helpers.txt |   35 ++++-
 Makefile                             |   16 ++-
 builtin-archive.c                    |   17 ++-
 transport-helper.c                   |  270 ++++++++++++++++++++++++++++-----
 transport.c                          |  258 ++++++++++++++++++++++++++------
 transport.h                          |   32 ++++
 7 files changed, 533 insertions(+), 100 deletions(-)
