From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 2/4] FindToolbar port to the new history page.
Date: Mon, 31 Mar 2008 02:19:14 -0400
Message-ID: <20080331061914.GK10274@spearce.org>
References: <1206890325-3732-1-git-send-email-rogersoares@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, robin.rosenberg@dewire.com
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Mon Mar 31 08:20:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgDNC-0005I2-QV
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 08:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbYCaGTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 02:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131AbYCaGTU
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 02:19:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35930 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbYCaGTT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 02:19:19 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JgDMS-0007b0-7x; Mon, 31 Mar 2008 02:19:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2A9DD20FBAE; Mon, 31 Mar 2008 02:19:15 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1206890325-3732-1-git-send-email-rogersoares@intelinet.com.br>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78559>

"Roger C. Soares" <rogersoares@intelinet.com.br> wrote:
> The find toolbar already generates a list of table rows that need
> highlighting. The hightlight flag + RevFilter solution currently
> doesn't support all the features that the find toolbar has, so for
> this port the toolbar is replacing the highlight flag.

Hmm.  So what functionality did the highlight flag + RevFilter
not get you?  It supports both regex as well as non-regex matches,
is quick, and can be joined together with other filters.  A lot of
the code in the FindToolbarThread should drop out.
 
> @@ -71,6 +70,8 @@ class CommitGraphTable {
>  
>  	private final TableViewer table;
>  
> +	private final Table rawTable;
> +

This field isn't necessary.  "table.getTable()" will get you the
same widget.

> diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindResults.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindResults.java
> new file mode 100644
> index 0000000..0202a70
> --- /dev/null
> +++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindResults.java
> @@ -0,0 +1,184 @@
...
> +public class FindResults {
> +	private Map<Integer, Integer> matchesMap = new LinkedHashMap<Integer, Integer>();
> +
> +	Integer[] keysArray;
> +
> +	private int matchesCount;
> +
...
> +	public synchronized boolean isFoundAt(int index) {
> +		return matchesMap.containsKey(new Integer(index));

So this is doing basically the same thing as the highlight RevFlag
(give a boolean about match status for a given RevCommit) but needs
to consult a HashMap by creating a temporary boxed Integer, and this
is deep down inside of the painting code for the table.  Urrgh.

> diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbar.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbar.java
> new file mode 100644
> index 0000000..eae0cc4
> --- /dev/null
> +++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbar.java
> @@ -0,0 +1,457 @@
...
> +public class FindToolbar extends Composite {
...
> +	private void createToolbar() {
...
> +		final ToolItem prefsItem = new ToolItem(toolBar, SWT.DROP_DOWN);
> +		final Menu prefsMenu = new Menu(this.getShell(), SWT.POP_UP);
> +		final MenuItem caseItem = new MenuItem(prefsMenu, SWT.CHECK);
> +		caseItem.setText("Ignore case");

These strings should be in UIText, and UIText.properties, so they
can be translated strings.

> +		committerItem.addSelectionListener(new SelectionAdapter() {
> +			public void widgetSelected(SelectionEvent e) {
> +				prefs.setValue(UIPreferences.FINDTOOLBAR_COMMITTER,
> +						committerItem.getSelection());
> +				Activator.getDefault().savePluginPreferences();
> +				clear();
> +			}
> +		});
> +		committerItem.setSelection(prefs
> +				.getBoolean(UIPreferences.FINDTOOLBAR_COMMITTER));

Would it make sense to abstract out and reuse the BooleanPrefAction
class I added to GitHistoryPage in ea3f1e7a7684b8?  

> diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbarThread.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbarThread.java
> new file mode 100644
> index 0000000..931f82b
> --- /dev/null
> +++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbarThread.java
> @@ -0,0 +1,237 @@
...
> +public class FindToolbarThread extends Thread {

Shouldn't this maybe be a Job instead, and scheduled on the History
site so the History title bar goes italics and the user can see
the progress meter in the status bar of the workspace and in their
Progress view?

> +	private static Display display = Display.getDefault();

I'm not an SWT expert, but I think hanging onto a Display reference
from a class static isn't a good idea.

> +	private static int globalThreadIx = 0;

Shouldn't this be a volatile, or an AtomicInteger, or protected by
a synchronized block?

> +	public void run() {
> +		execFind(currentThreadIx, fileRevisions, pattern, toolbar, ignoreCase,
> +				findInCommitId, findInComments, findInAuthor, findInCommitter);
> +	}
> +
> +	private synchronized static void execFind(int threadIx,
> +			SWTCommit[] fileRevisions, final String pattern,
> +			final FindToolbar toolbar, boolean ignoreCase,
> +			boolean findInCommitId, boolean findInComments,
> +			boolean findInAuthor, boolean findInCommitter) {

Wow.  That's black magic.  You are blocking the threads from
doing multiple searches at once by synchonizing on the static
method, but since you are in an instance method you had to pass
everything through as arguments.  :-|

It would be a lot easier to follow if this was an instance member,
and thus had access to the instance fields, and if you used an
explicit lock, e.g.:

	private static final Object EXEC_LOCK = new Object();

	public void run() {
		synchronized (EXEC_LOCK) {
			execFind();
		}
	}

	private void execFind() { ... }


-- 
Shawn.
