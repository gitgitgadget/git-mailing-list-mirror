From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 3/3] Add a ref log reader class
Date: Sun, 7 Jun 2009 15:21:54 -0700
Message-ID: <20090607222154.GD16497@spearce.org>
References: <1244405951-21808-1-git-send-email-robin.rosenberg@dewire.com> <1244405951-21808-2-git-send-email-robin.rosenberg@dewire.com> <1244405951-21808-3-git-send-email-robin.rosenberg@dewire.com> <1244405951-21808-4-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 00:25:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDQny-00088P-2t
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 00:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043AbZFGWVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 18:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753875AbZFGWVx
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 18:21:53 -0400
Received: from george.spearce.org ([209.20.77.23]:58575 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbZFGWVw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 18:21:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D1638381FD; Sun,  7 Jun 2009 22:21:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1244405951-21808-4-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121014>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ReflogReader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ReflogReader.java
> new file mode 100644
> index 0000000..15591af
> --- /dev/null
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ReflogReader.java
> @@ -0,0 +1,186 @@
...
> +public class ReflogReader {
> +	/**
> +	 * Parsed reflog entry
> +	 */
> +	static public class Entry {
> +		Entry(byte[] raw, int pos) {
> +			oldId = ObjectId.fromString(raw, pos);
> +			if (raw[pos + Constants.OBJECT_ID_LENGTH * 2] != ' ')
> +				throw new IllegalArgumentException(
> +						"Raw log message does not parse as log entry");

Please, for the sake of everyone's sanity, increment pos after you
read oldId.  Then its just raw[pos++] != ' ' here, and the next
line for newId is even shorter.

> +			int p1 = RawParseUtils.next(raw, p0 + 1, ':');
> +			if (p1 == -1)
> +				throw new IllegalArgumentException(
> +						"Raw log message does not parse as log entry");

Technically, missing a ':' is legal.  Everything after the '\t'
is the comment.  It may be splittable into an action/comment,
it might not be.

> +			action = RawParseUtils.decode(raw, p0, p1-1).trim();
> +			int p2 = RawParseUtils.nextLF(raw, p1 + 1);
> +			if (p2 == -1)
> +				throw new IllegalArgumentException(
> +						"Raw log message does not parse as log entry");
> +			comment = RawParseUtils.decode(raw, p1, p2).trim();

trim() on these shouldn't be necessary.  If you parse the line
right, you can avoid handing the '\t' and the '\n' to the decode,
and then whatever is left is what was given to the logger, and we
should faithfully return that to the caller.  Its unlikely to have
unncessary whitespace, so the trim is just wasting CPU looking
for it.

> +		private ObjectId oldId;
> +
> +		private ObjectId newId;
> +
> +		private PersonIdent who;
> +
> +		private String action;
> +
> +		private String comment;

Style nit: I much prefer fields to appear before the constructor.

> +	}
...
> +	public List<Entry> getReverseEntries(int max) throws IOException {
> +		FileInputStream fileInputStream;
> +		try {
> +			fileInputStream = new FileInputStream(logName);
> +		} catch (FileNotFoundException e) {
> +			return Collections.emptyList();
> +		}

Please ensure fileInputStream doesn't leak and is closed before
this method block returns.

> +		if (logName.length() > Integer.MAX_VALUE)
> +			// implementation limit, will suck with smaller files too
> +			throw new IOException("Cannot handle reflog larger than "
> +					+ Integer.MAX_VALUE + " bytes");

Style nit: Please wrap this huge block in {}, its easier to read
when there are more than one line dangling below.

> +		byte[] log = new byte[(int) logName.length()];

Please use fileInputStream.getChannel().size() as it does an fstat()
rather than a stat() on the path.

But I'd rather just read the file backwards, with a RandomAccessFile
and what amounts to a reverse version of BufferedInputStream.

> +		NB.readFully(fileInputStream, log, 0, log.length);
> +		int rs = log.length - 2; // skip terminating \n

If the file is currently being appended to, it might not end in
'\n'.  Something to keep in mind.

-- 
Shawn.
