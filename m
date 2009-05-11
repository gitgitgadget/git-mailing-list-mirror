From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [JGIT PATCH 2/2] Decrease the fetch pack client buffer to the lower minimum
Date: Sun, 10 May 2009 17:43:20 -0700
Message-ID: <7vfxfctqon.fsf@alter.siamese.dyndns.org>
References: <1241995685-13260-1-git-send-email-spearce@spearce.org>
	<1241995685-13260-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 11 02:46:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Jf4-0001dq-CX
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 02:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbZEKAnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 20:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbZEKAnV
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 20:43:21 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:36050 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbZEKAnU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 20:43:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090511004321.BVUU18948.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 10 May 2009 20:43:21 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id q0jL1b00G4aMwMQ030jLWU; Sun, 10 May 2009 20:43:21 -0400
X-Authority-Analysis: v=1.0 c=1 a=68f4PgtGCZ0A:10 a=wvpHRPnWvyEA:10
 a=oAYF_C9AAAAA:8 a=G2481yspHQ4e3FvRNlUA:9 a=c7j9imR1qL68Np4Qve8A:7
 a=Nmh_Mi5xPuTvv70XJm6HR03l33wA:4 a=R0wQ3QzoQ0IA:10
X-CM-Score: 0.00
In-Reply-To: <1241995685-13260-2-git-send-email-spearce@spearce.org> (Shawn O. Pearce's message of "Sun\, 10 May 2009 15\:48\:05 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118762>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> This is the lowest buffer size we actually require to keep the
> client and server sides from deadlocking against each other.

Is this about the fetch-pack protocol where

 (1) upload-pack shows what it has; fetch-pack keeps reading until it sees
     a flush; then

 (2) fetch-pack shows what it wants; upload-pack keeps reading; then

 (3) fetch-pack sends a bunch of have's, followed by a flush; upload-pack
     keeps reading and then responds with an ACK-continue or NAK, which
     fetch-pack reads; this step continues zero or more times; and then
     finally

 (4) fetch-pack sends a bunch of have's, followed by a flush; upload-pack
     keeps reading and then responds with an ACK, fetch-pack says done.

Where do you need "enough buffer"?  The conversation looks very much "it's
my turn to talk", "now it's your turn to talk and I'll wait until I hear
from you", to me.  I am puzzled.

> Also added documentation, and renamed the symbol to better match
> its real purpose; naming the lower threshold we can allow for a
> buffer.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  .../jgit/transport/BasePackFetchConnection.java    |   10 +++++++++-
>  .../org/spearce/jgit/transport/TransportLocal.java |    2 +-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
> index eaa94bd..1d1b801 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
> @@ -89,7 +89,15 @@
>  	 */
>  	private static final int MAX_HAVES = 256;
>  
> -	protected static final int MAX_CLIENT_BUFFER = MAX_HAVES * 46 + 1024;
> +	/**
> +	 * Amount of data the client sends before starting to read.
> +	 * <p>
> +	 * Any output stream given to the client must be able to buffer this many
> +	 * bytes before the client will stop writing and start reading from the
> +	 * input stream. If the output stream blocks before this many bytes are in
> +	 * the send queue, the system will deadlock.
> +	 */
> +	protected static final int MIN_CLIENT_BUFFER = 2 * 32 * 46 + 4;
>  
>  	static final String OPTION_INCLUDE_TAG = "include-tag";
>  
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
> index cffdba1..428f73e 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
> @@ -175,7 +175,7 @@ InternalLocalFetchConnection() throws TransportException {
>  					// force the buffer to be big enough, otherwise it
>  					// will deadlock both threads.
>  					{
> -						buffer = new byte[MAX_CLIENT_BUFFER];
> +						buffer = new byte[MIN_CLIENT_BUFFER];
>  					}
>  				};
>  				out_w = new PipedOutputStream(out_r);
> -- 
> 1.6.3.48.g99c76
