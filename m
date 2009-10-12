From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGit-io-RFC-PATCH v2 2/4] Add JGit IO SPI and default
	implementation
Date: Mon, 12 Oct 2009 07:57:42 -0700
Message-ID: <20091012145741.GM9261@spearce.org>
References: <1255270073-14205-1-git-send-email-imyousuf@gmail.com> <1255270073-14205-2-git-send-email-imyousuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, egit-dev@eclipse.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: imyousuf@gmail.com
X-From: git-owner@vger.kernel.org Mon Oct 12 17:10:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxMXk-0003eg-4w
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 17:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbZJLO6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 10:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755823AbZJLO6T
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 10:58:19 -0400
Received: from george.spearce.org ([209.20.77.23]:34899 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbZJLO6S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 10:58:18 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 27150381FE; Mon, 12 Oct 2009 14:57:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1255270073-14205-2-git-send-email-imyousuf@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130026>

imyousuf@gmail.com wrote:
> The SPI mainly focus's in providing an API to JGit to be able to perform
> similar operations to that of java.io.File. All direct I/O is based on the
> java.io.Input/OutputStream classes.
> 
> Different JGit IO SPI provider is designed to be URI scheme based and thus
> the default implementation is that of "file" scheme. SPI provider will be
> integrated by their respective users in a manner similar to that of JDBC
> driver registration. There is a SystemStorageManager that has similar
> registration capabilities and the system storage providers should be
> registered with the manager in one of the provided ways.

I think this may be a bit in the wrong direction for what we are
trying to accomplish.

A number of people really want to map Git onto what is essentially
Google's BigTable schema.  Aside from Google's own BigTable product
(which I want to use Git on at work, because it would vastly simplfiy
my system administration duties at $DAYJOB) there is Cassandra and
Hadoop HBase which implement the same schema semantics.

None of those systems implement file streams, they implement cell
storage in a non-transactional system with a semi-dynamic schema.

Some people have built transactional semantics on top of these
storage layers, e.g. Google AppEngine provides multiple row
transactions through some magic sauce layered on top of BigTable.
I'm sure people will build similar tools on top of Cassandra
and HBase.

Where I'm trying to go with this is that things that are stored
in files on the filesystem in traditional Git wouldn't normally be
mapped into "byte streams" in a BigTable-ish system, or even the
JDBC-ish system you were describing.

For .git/config we might want to map config variable names into
keys in the table, with values stored in cells.  This makes it
easier to query or edit the data.

Fortunately, "Config" is abstract enough that we could subclass
it with a CassandraConfig and simply use that instance when on a
based Cassandra storage system.  No file streams required.  Ditto
for a JdbcConfig.

For RefDatabase, we'd want to do the same and avoid the concept of
packed-refs altogether.  Each Ref should go into its own row in a
Cassandra storage system, and essentially act as a loose object.
Ditto with JDBC.

We'd probably never need to read-or-write the info/refs or
objects/info/packs listings.

And I think that's everything that a bare repository needs, aside
from ObjectDatabase, which is already mostly abstract anyway.

-- 
Shawn.
