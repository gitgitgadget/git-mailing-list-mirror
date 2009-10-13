From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGit-io-RFC-PATCH v2 2/4] Add JGit IO SPI and default
	implementation
Date: Tue, 13 Oct 2009 08:15:23 -0700
Message-ID: <20091013151522.GR9261@spearce.org>
References: <1255270073-14205-1-git-send-email-imyousuf@gmail.com> <1255270073-14205-2-git-send-email-imyousuf@gmail.com> <20091012145741.GM9261@spearce.org> <7bfdc29a0910121830y4dc9b3efpe17860e04457988d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, egit-dev@eclipse.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: Imran M Yousuf <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 17:19:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxj9u-000174-Nc
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 17:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760224AbZJMPQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 11:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760206AbZJMPQA
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 11:16:00 -0400
Received: from george.spearce.org ([209.20.77.23]:33674 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760221AbZJMPP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 11:15:59 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 235BC381FE; Tue, 13 Oct 2009 15:15:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7bfdc29a0910121830y4dc9b3efpe17860e04457988d@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130165>

Imran M Yousuf <imyousuf@gmail.com> wrote:
> Firstly, I am sorry but I am not intelligent enough to perceive, how
> do the user decide which instance of Config to use? I personally think
> that there is no API to achieve what you just mentioned :(; i.e. the
> user will have know CassandraConfig directly.

Yes.  Well, almost.

The user will have to know that s/he wants a CassandraRepository or
a JdbcRepository in order to obtain the abstract Repository handle.
Each of these will need different configuration, possibly data which
is too complex to simply cram into a URL string, so I was expecting
the application would construct the concrete Repository class and
configure it with the proper arguments required for contact with
the underlying storage.

Since the Repository wants several things associated with it, each
concrete Repository class knows what concrete Config, ObjectDatabase
and RefDatabase it should create.  Those concrete classes know how
to read a repository stored on that medium.

> Secondly, I instead was
> thinking of porting JGit for that matter to any system supporting
> streams (not any specific sub-class of them), such HBase/BigTable or
> HDFS anything.... Thirdly, I think we actually have several task in
> hand and I would state them as -
> 
> 1. First introduce the I/O API such that it completely replaces java.io.File
> 2. Secondly segregate persistence of for config (or config like
> objects) and introduce a SPI for them for smarter storage.

Supporting streams on an arbitrary backend is difficult.  DHTs like
BigTable/Cassandra aren't very good at providing streams, they tend
to have a limit on how big a row can be.  They tend to have very
slow read latencies, but can return a small block of consecutive
rows in one reply.

I want to talk about the DHT backend more with Scott Chacon at the
GitTogether, but I have this feeling that just laying a pack file
into a stream in a DHT is going to perform very poorly.

Likewise JDBC has similar performance problems, you can only store
so much in a row before performance of the RDBMS drops off sharply.
You can get a handful of rows in a single reply pretty efficiently,
but each query takes longer than you'd like.  Yes, there is often
a BLOB type that allows large file storage, but different RDBMS
support these differently and have different performance when it
comes to accessing the BLOB types.  Some don't support random access,
some do.  Even if they do support random access read, writing a large
2 GiB repository's pack file after repacking it would take ages.

Once you get outside of the pack file, *everything* else git stores
is either a loose object, or very tiny text files (aka refs, their
logs, config).  The loose object case should be handled by the same
thing that handles the bulk of the object store, loose objects are
a trivial thing compared to packed objects.

The refs, the ref logs, and the config are all structured text.
If you lay a Git repository down into a database of some sort,
I think its reasonable to expect that the schema for these items
in that database permits query and update using relatively native
primitives in that database.  E.g. if you put this in SQL I would
expect a schema like:

  CREATE TABLE refs (
   repository_id INT NOT NULL
  ,name VARCHAR(255) NOT NULL
  ,id CHAR(40)
  ,target VARCHAR(255)
  ,PRIMARY KEY (repository_id, name)
  ,CHECK (id IS NOT NULL OR target IS NOT NULL));
 
  CREATE TABLE reflogs (
   repository_id INT NOT NULL
  ,name VARCHAR(255) NOT NULL
  ,old_id CHAR(40) NOT NULL
  ,new_id CHAR(40) NOT NULL
  ,committer_name VARCHAR(255)
  ,committer_email VARCHAR(255)
  ,committer_date TIMESTAMP NOT NULL
  ,message VARCHAR(255)
  ,PRIMARY KEY (repository_id, name, committer_date));

  CREATE TABLE config (
   repository_id INT NOT NULL
  ,section VARCHAR(255) NOT NULL
  ,group VARCHAR(255)
  ,name VARCHAR(255) NOT NULL
  ,value VARCHAR(255)
  ,PRIMARY KEY(repository_id, section, group, name, value))

This makes it easier to manipulate settings, you can use direct
SQL UPDATE to modify the configuration, or SELECT to scan through
reflogs.  Etc.

If we just threw everything as streams into the database this
would be a lot more difficult to work with through the database's
own native query and update interface.  You'd lose alot of the
benefits of using a database, but still be paying the massive price
in performance.
 
> I am not thinking of storing "only" the bare content of a git
> repository, but I intent to be able to also store the versioned
> contents it self as well.

When I say "bare repository" I only mean a repository without a
working directory.  It still holds the complete revision history.
If you wanted a git repository on Cassandra but wanted to actually
have a working directory checkout, you'd need the local filesystem
for the checkout and .git/index, but could otherwise keep the objects
and refs in Cassandra.  Its nuts... but in theory one could do it.

-- 
Shawn.
