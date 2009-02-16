From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] 1/2: Externalizable items
Date: Mon, 16 Feb 2009 09:20:25 -0800
Message-ID: <20090216172025.GE18525@spearce.org>
References: <320075ff0902160845m264f78cdh8dc5307b24f4c3ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 18:21:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ7AI-0001wP-30
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 18:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbZBPRU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 12:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbZBPRU0
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 12:20:26 -0500
Received: from george.spearce.org ([209.20.77.23]:49303 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbZBPRUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 12:20:25 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1CEB4381FF; Mon, 16 Feb 2009 17:20:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <320075ff0902160845m264f78cdh8dc5307b24f4c3ed@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110214>

Nigel Magnay <nigel.magnay@gmail.com> wrote:
> Make parts of jgit externalizable, so that they can be marshalled over
> the wire or onto disk,
> using formats from git mailing list.

As Dscho pointed out, a bit more detail here would be appreciated.
 
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
> b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
> index 52ce0d4..1385325 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
> @@ -56,6 +60,13 @@
>  	}
> 
>  	/**
> +	 * Empty constructor, for Externalizable.
> +	 */
> +	public ObjectId() {
> +		// For Externalizable
> +	}

Yikes.  Do we really need a public no-arg constructor for
Externalizable?  If we do, maybe we should use Serializable instead
so we can hide this constructor.  I don't like the idea of people
creating ObjectId.zeroId() by new ObjectId().  That's not a pattern
we should encourage.

> @@ -269,4 +280,22 @@ protected ObjectId(final AnyObjectId src) {
>  	public ObjectId toObjectId() {
>  		return this;
>  	}
> +
> +	public void readExternal(ObjectInput in) throws IOException,
> +			ClassNotFoundException {
> +		byte[] sha1 = new byte[20];
> +		in.read(sha1);
> +		
> +		w1 = NB.decodeInt32(sha1, 0);
> +		w2 = NB.decodeInt32(sha1, 4);
> +		w3 = NB.decodeInt32(sha1, 8);
> +		w4 = NB.decodeInt32(sha1, 12);
> +		w5 = NB.decodeInt32(sha1, 16);
> +	}
> +
> +	public void writeExternal(ObjectOutput out) throws IOException {
> +		byte[] sha1 = new byte[20];
> +		copyRawTo(sha1, 0);
> +		out.write(sha1);
> +	}

Hmm.  I was thinking of just writing the 5 ints out, and reading
the 5 ints back in.  We're always talking to another Java process.
The ints are written in network byte order anyway on a serialization
stream.  Doing this conversion to a byte[] thrases the caller's
per-thread new generation rather hard.  I think applications using
this type in a serialization stream would expect it to be quick.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
> b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
> index 5bbf664..22443b4 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
> +
> +	public void readExternal(ObjectInput in) throws IOException,
> +			ClassNotFoundException {
> +		name = in.readUTF();
> +		int items = in.readInt();
> +
> +		Map<String, Collection<String>> map = new HashMap<String,
> Collection<String>>();
> +		for (int i = 0; i < items; i++) {
> +			String key = in.readUTF();
> +			String value = in.readUTF();

Why not just serialize the Map in the stream?

-- 
Shawn.
