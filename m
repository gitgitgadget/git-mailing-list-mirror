From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] jgit: upload-pack: Force an fd flush after receiving
	flush pkt from client
Date: Mon, 16 Mar 2009 13:05:15 -0700
Message-ID: <20090316200515.GQ22920@spearce.org>
References: <1237224864-15649-1-git-send-email-dima@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dima Zavin <dima@android.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 21:07:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjJ5F-0003eA-27
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 21:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbZCPUFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 16:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754174AbZCPUFT
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 16:05:19 -0400
Received: from george.spearce.org ([209.20.77.23]:55642 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834AbZCPUFS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 16:05:18 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E4CB838211; Mon, 16 Mar 2009 20:05:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1237224864-15649-1-git-send-email-dima@android.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113361>

Dima Zavin <dima@android.com> wrote:
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
> index 71acda1..80c154b 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
> @@ -351,7 +351,7 @@ private void negotiate() throws IOException {
>  			if (line.length() == 0) {
>  				if (commonBase.isEmpty() || multiAck)
>  					pckOut.writeString("NAK\n");
> -
> +				pckOut.flush();
>  			} else if (line.startsWith("have ") && line.length() == 45) {
>  				final ObjectId id = ObjectId.fromString(line.substring(5));
>  				if (matchHave(id)) {

Applied, but with this more verbose commit message:

--8<--
upload-pack: Force an fd flush after receiving flush pkt from client

The client is blocked waiting for an ACK or NAK line from the server.
If we don't call flush() here there is a very good chance the
ACK/NAK is stuck in our stream buffer within the JRE, and doesn't
make it into the kernel's TCP buffer.  This causes the server to
wait for more have lines, and the client to wait for the ACK/NAK,
and the entire thing just deadlocks.

We flush anytime we see a pkt-line flush command, as there may be
buffered ACK lines from prior evaulations that need to be sent to
the waiting client.

Signed-off-by: Dima Zavin <dima@android.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

-- 
Shawn.
