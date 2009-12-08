From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 0/3] transport: catch non-fast-forwards
Date: Tue, 8 Dec 2009 22:34:13 +0800
Message-ID: <20091208223413.98e99d3e.rctay89@gmail.com>
References: <20091204144822.a61355d2.rctay89@gmail.com>,
 <alpine.LNX.2.00.0912040153090.14365@iabervon.org>,
 <20091204102039.GB27495@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Sverre Rabbelier" <srabbelier@gmail.com>,
	"Clemens Buchacher" <drizzd@aon.at>, "Jeff King" <peff@peff.net>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 15:34:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI195-0004IQ-5J
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 15:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516AbZLHOeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 09:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752883AbZLHOeS
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 09:34:18 -0500
Received: from mail-yw0-f198.google.com ([209.85.211.198]:33523 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbZLHOeR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 09:34:17 -0500
Received: by ywh36 with SMTP id 36so5423592ywh.15
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 06:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=p0U0/ZIw5tVigSHcA68KQwvoOiYMR0DdyIXol+d7xvY=;
        b=c8tug1oCSrVNn9nv+S7rjIQc8zJoiWAjCSgS6kRAy4nJT+MQIGzPielrUVeT0dbNoK
         Ibl/L485NOQ4Asdn/91FfvVRW8K91MhBH2c1lyap7iY0BYuW2hDGl99d9gj5SO4UVCQ/
         sXFGAEATe1jq5uxeDy6nNy8xebobrr1TlaXLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=XBHOxCsZRnK5vS33yDtEIVtxUtYoP266PIhdLNlHyS/5qlE2duwTP4+vru4ovx9dm2
         Bvta/1eb4wgMrmY9mT7VinvwQGIYlEoE63JihflidjaQ50K2ZKxglFGuT8uRvGER2f8f
         pl7kA+2R7A4aFf0s/sSz9qqLjQlrWjtqwOGpE=
Received: by 10.151.1.20 with SMTP id d20mr7314330ybi.119.1260282864274;
        Tue, 08 Dec 2009 06:34:24 -0800 (PST)
Received: from your-cukc5e3z5n (cm67.zeta153.maxonline.com.sg [116.87.153.67])
        by mx.google.com with ESMTPS id 16sm3431265gxk.11.2009.12.08.06.34.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Dec 2009 06:34:23 -0800 (PST)
In-Reply-To: <20091204125042.c64f347d.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134877>

Daniel, I've reworked the refactoring of ref status logic, like you
mentioned, such that transport_push() calls the generic function before
calling the transport->push_refs() implementation.

Junio, although this series affects http transports (smart), please treat
this series as separate from 'tr/http-updates' in 'next'.

Summary for those who missed v1:
  This patch series applies on top of 'next', and deals with alerting
  the user to non-fast-forward pushes when using helpers (smart).

  Previously, git silently exited. This situation involves the curl
  helper and the smart protocol. The fast-forward push is only detected
  when curl executes the rpc client (git-send-pack). Now, we detect it
  before telling the helper to push.

Changes from v1:
 - reworked refactoring of ref status logic (patch 1)
 - rewrote the patch for transport_push() (patch 2)
 - minor rewording of commit message (patch 3)

Tay Ray Chuan (3):
  refactor ref status logic for pushing
  transport.c::transport_push(): make ref status affect return value
  transport-helper.c::push_refs(): emit "no refs" error message

 builtin-send-pack.c |   50 +++++++++++---------------------------------------
 remote.c            |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 remote.h            |    2 ++
 transport-helper.c  |   18 ++++++++++--------
 transport.c         |   11 +++++++++--
 5 files changed, 82 insertions(+), 49 deletions(-)

--
Cheers,
Ray Chuan
