From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] 1/2 : (reworked) Externalizable/Serializable Items
Date: Wed, 18 Feb 2009 08:30:02 -0800
Message-ID: <20090218163002.GB22848@spearce.org>
References: <320075ff0902161212s1980cd70r8cdc4c21550333ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 17:32:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZpKg-0006Ha-Cx
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 17:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbZBRQaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 11:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbZBRQaF
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 11:30:05 -0500
Received: from george.spearce.org ([209.20.77.23]:54568 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbZBRQaE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 11:30:04 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id C593F381FF; Wed, 18 Feb 2009 16:30:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <320075ff0902161212s1980cd70r8cdc4c21550333ee@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110555>

Nigel Magnay <nigel.magnay@gmail.com> wrote:
> +public class ObjectId extends AnyObjectId implements Serializable {

We should define our own serialVersionUID:

  private static final long serialVersionUID = 1L;

is good enough to make Java happy.

> @@ -269,4 +273,20 @@ protected ObjectId(final AnyObjectId src) {
>  	public ObjectId toObjectId() {
>  		return this;
>  	}
> +
> +	private void writeObject(ObjectOutputStream os)  throws IOException {
> +	private void readObject(ObjectInputStream ois)  throws IOException {

Minor nit: Only 1 space between ) and throws, please.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
> b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
> index 5bbf664..899f73f 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
> @@ -53,7 +57,7 @@
>   * describing how refs should be transferred between this repository and the
>   * remote repository.
>   */
> -public class RemoteConfig {
> +public class RemoteConfig implements Serializable {

Please set a serialVersionUID.

> @@ -382,4 +386,77 @@ public TagOpt getTagOpt() {
>  	public void setTagOpt(final TagOpt option) {
>  		tagopt = option != null ? option : TagOpt.AUTO_FOLLOW;
>  	}
> +	
> +	private void writeObject(ObjectOutputStream os) throws IOException {
> +
> +	    // Name
> +	    os.writeUTF(name);
> +	
> +	    // Key, Value pairs
> +	    for (URIish uri : uris) {
> +            os.writeUTF(KEY_URL);
> +            os.writeUTF(uri.toPrivateString());
> +        }
> +
> +        for (RefSpec refspec : fetch) {

There is some sort of whitespace damage here, the second for loop
is not lined up at the same starting column as the first for loop.
My guess is, you have tabs in here.  We only indent with spaces.

> +            os.writeUTF(KEY_FETCH);
> +            os.writeUTF(refspec.toString());
> +        }
> +
> +        for (RefSpec refspec : push) {
> +        	os.writeUTF(KEY_PUSH);
> +            os.writeUTF(refspec.toString());
> +        }

Should we maybe allow RefSpec to serialize itself with
os.writeObject() rather than using writeUTF() directly?

FWIW, I did find this new implementation to be much easier to read.
Thanks.

-- 
Shawn.
