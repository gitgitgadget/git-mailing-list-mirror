From: Matt Mackall <mpm@selenic.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Wed, 31 Jan 2007 16:25:07 -0600
Message-ID: <20070131222507.GO10108@waste.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
	<20070130165548.GF25950@spearce.org>
	<20070131015555.GA1944@thunk.org> <eppshi$1l4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mercurial@selenic.com, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: mercurial-bounces@selenic.com Wed Jan 31 23:42:31 2007
Return-path: <mercurial-bounces@selenic.com>
Envelope-to: gcvmd-mercurial@gmane.org
Received: from waste.org ([66.93.16.53])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCO9s-0000Kv-Bd
	for gcvmd-mercurial@gmane.org; Wed, 31 Jan 2007 23:42:28 +0100
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l0VMSPHL012703;
	Wed, 31 Jan 2007 16:28:30 -0600
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id
	l0VMP87s012350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 31 Jan 2007 16:25:08 -0600
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id l0VMP7TA012348;
	Wed, 31 Jan 2007 16:25:07 -0600
Content-Disposition: inline
In-Reply-To: <eppshi$1l4$1@sea.gmane.org>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new
X-BeenThere: mercurial@selenic.com
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: mercurial.selenic.com
List-Unsubscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=unsubscribe>
List-Archive: <http://www.selenic.com/pipermail/mercurial>
List-Post: <mailto:mercurial@selenic.com>
List-Help: <mailto:mercurial-request@selenic.com?subject=help>
List-Subscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=subscribe>
Sender: mercurial-bounces@selenic.com
Errors-To: mercurial-bounces@selenic.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38300>

On Wed, Jan 31, 2007 at 11:56:01AM +0100, Jakub Narebski wrote:
> Theodore Tso wrote:
> 
> > On Tue, Jan 30, 2007 at 11:55:48AM -0500, Shawn O. Pearce wrote:
> >> I think hg modifies files as it goes, which could cause some issues
> >> when a writer is aborted.  I'm sure they have thought about the
> >> problem and tried to make it safe, but there isn't anything safer
> >> than just leaving the damn thing alone.  :)
> > 
> > To be fair hg modifies files using O_APPEND only.  That isn't quite as
> > safe as "only creating new files", but it is relatively safe.
> 
> >From (libc.info):
> 
>  -- Macro: int O_APPEND
>      The bit that enables append mode for the file.  If set, then all
>      `write' operations write the data at the end of the file, extending
>      it, regardless of the current file position.  This is the only
>      reliable way to append to a file.  In append mode, you are
>      guaranteed that the data you write will always go to the current
>      end of the file, regardless of other processes writing to the
>      file.  Conversely, if you simply set the file position to the end
>      of file and write, then another process can extend the file after
>      you set the file position but before you write, resulting in your
>      data appearing someplace before the real end of file.
> 
> I don't quote understand how that would help hg (Mercurial) to have
> operations like commit, pull/fetch or push atomic, i.e. all or nothing.

That's because it's unrelated.

> In hg you have to update individual files (blobs buckets) storing delta
> and perhaps full version, update manifest file (flat tree) and update
> changelog (commit): what happens if for example there are two concurrent
> operations trying to update repository, e.g. two push operations in parallel
> (from two different developers), or fetch from cron and commit?

Mercurial has write-side locks so there can only ever be one writer at
a time. There are no locks needed on the read side, so there can be
any number of readers, even while commits are happening.

> What happens if operation is interrupted (e.g. lost connection to
> network during fetch)?

We keep a simple transaction journal. As Mercurial revlogs are
append-only, rolling back a transaction just means truncating all
files in a transaction to their original length.

> In git both situations result in some prune-able and fsck-visible crud in
> repository, but repository stays uncorrupted, and all operations are atomic
> (all or nothing).

If a Mercurial transaction is interrupted and not rolled back, the
result is prune-able and fsck-visible crud. But this doesn't happen
much in practice.

The claim that's been made is that a) truncate is unsafe because Linux
has historically had problems in this area and b) git is safer because
it doesn't do this sort of thing. 

My response is a) those problems are overstated and Linux has never
had difficulty with the sorts of straightforward single writer
operations Mercurial uses and b) normal git usage involves regular
rewrites of data with packing operations that makes its exposure to
filesystem bugs equivalent or greater.

In either case, both provide strong integrity checks with recursive
SHA1 hashing, zlib CRCs, and GPG signatures (as well as distributed
"back-up"!) so this is largely a non-issue relative to traditional
systems.

-- 
Mathematics is the supreme nostalgia of our time.
