From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Implement packed refs
Date: Mon, 14 May 2007 18:45:33 -0400
Message-ID: <20070514224533.GA28832@spearce.org>
References: <11790995572233-git-send-email-robin.rosenberg@dewire.com> <11790995571082-git-send-email-robin.rosenberg@dewire.com> <11790995573817-git-send-email-robin.rosenberg@dewire.com> <11790995571637-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue May 15 00:45:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnjIY-0006XG-4s
	for gcvg-git@gmane.org; Tue, 15 May 2007 00:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435AbXENWpj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 18:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755557AbXENWpj
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 18:45:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56948 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435AbXENWpi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 18:45:38 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HnjIE-0007GE-7R; Mon, 14 May 2007 18:45:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 732FF20FBAE; Mon, 14 May 2007 18:45:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <11790995571637-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47297>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> index 76191be..3b2a82c 100644
> @@ -411,6 +412,10 @@ public class Repository {
>  	private Ref readRefBasic(String name) throws IOException {
>  		int depth = 0;
>  		REF_READING: do {
> +			ObjectId id = packedRefs.get(name);
> +			if (id != null)
> +				return new Ref(null, id);
> +
>  			final File f = new File(getDirectory(), name);
>  			if (!f.isFile()) {
>  				return new Ref(f, null);

This is actually backwards.  Git checks the loose ref first, and
then the packed ref.  The reason is so that users can pack all
of their refs (git pack-refs --all) and then just create new ref
files for those that they change, rather than rewriting the entire
packed-refs file over again.

I'm adding a commit after your series to correct this.

> +		} catch (IOException e) {
> +			e.printStackTrace();
> +		}

We really should be throwing exceptions back to the caller,
especially on things that could indicate corruption or other
problems with reading the repository contents.

-- 
Shawn.
