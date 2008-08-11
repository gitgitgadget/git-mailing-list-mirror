From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: RFC: Allow missing objects during packing
Date: Mon, 11 Aug 2008 11:28:39 -0700
Message-ID: <20080811182839.GJ26363@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 20:30:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSc9u-0006RG-6s
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 20:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756469AbYHKS2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 14:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754176AbYHKS2l
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 14:28:41 -0400
Received: from george.spearce.org ([209.20.77.23]:45384 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756442AbYHKS2k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 14:28:40 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 56A3038376; Mon, 11 Aug 2008 18:28:39 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91969>

So I have this horribly bizarre case that I just feel dirty telling
you about.  But I have to deal with it.  So here goes...

I want to publish a fork of an open source project, but I'm not
allowed to publish the base history of the project.  For political
reasons I can only publish patches/deltas, even though the project
is licensed under the LGPL.  Don't ask.  Seriously.  In 6 months
everyone will probably forget about this and I can just publish
the whole thing.  But not right now.

With this silly little patch to builtin-pack-objects I can make
it work by publishing what amounts to a shallow clone.  The fork
was created by doing something like this:

	$ git clone --bare git://upstream.org/proj.git upstream.git
	$ cd fork
	$ git remote add -f upstream ../upstream.git
	$ echo ../upstream.git/objects >.git/objects/info/alternates
	$ git repack -a -d -f -l

	# now fork/.git has only its "delta"
	# add the base trees, but not blobs
	#
	$ jgit --git-dir=../upstream.git tree-copy upstream/master .

	# remove the shared odb
	#
    $ rm .git/objects/info/alternates

Users who want to clone from fork.git have to do this:

	$ git clone -o upstream git://upstream.org/proj.git proj
	$ cd proj
	$ git remote add -f origin git://forky.org/fork.git
	remote: Counting objects: 5, done.
	remote: error: unable to find d30dcb7f07b6bf1a6cc5da4f3c1d0e6fc690dc45
	remote: git: unable to get type of object d30dremote: cb7f07b6bf1a6cc5da4f3c1d0e6fc690dc45: No such file or directory
	remote: Compressing objects: 100% (3/3), done.
	remote: Total 3 (delta 1), reused 0 (delta 0)
	Unpacking objects: 100% (3/3), done.

Basically this little patch just makes pack-objects issue the
warning, but then skip over the object and move on.

Later during deltification the selected base object has a type which
does not match any other object, so it never gets considered, and
there is no error caused by it not being present.  We just cannot
generate a delta during the fetch and the client winds up getting
a little larger download.

Thoughts?  Should I work this up into a real patch and try to get
it into the tree?  It seems pretty harmless to allow an object we
aren't going to transmit but that we want to use as a delta base
in a thin pack to be missing.  At worst we just get a little bit
more data transfer.

--8<--
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 2dadec1..0f29f14 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1097,7 +1097,7 @@ static void check_object(struct object_entry *entry)
 
 	entry->type = sha1_object_info(entry->idx.sha1, &entry->size);
 	if (entry->type < 0)
-		die("unable to get type of object %s",
+		warn("unable to get type of object %s",
 		    sha1_to_hex(entry->idx.sha1));
 }


And this is the Java program to build up the base tree, as otherwise
the thin pack creation code crashes out trying to build a list of
what the client already has/knows.  Since this is only the base
commit and its trees (no blobs, and no history beyond the base
commit) I should be able to get away with publishing it as part of
the fork.

--8<--
import org.kohsuke.args4j.Argument;
import org.spearce.jgit.lib.Constants;
import org.spearce.jgit.lib.ObjectId;
import org.spearce.jgit.lib.PackWriter;
import org.spearce.jgit.lib.Repository;
import org.spearce.jgit.lib.TextProgressMonitor;
import org.spearce.jgit.pgm.Command;
import org.spearce.jgit.pgm.TextBuiltin;
import org.spearce.jgit.revwalk.RevCommit;
import org.spearce.jgit.revwalk.RevObject;
import org.spearce.jgit.treewalk.TreeWalk;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.LinkedList;
import java.util.List;

@Command(name = "tree-copy", usage = "Copy a base commit and its trees")
public class TreeCopy extends TextBuiltin {
  @Argument(index = 0, required = true, metaVar = "commit", usage = "base commit")
  private RevCommit baseCommit;

  @Argument(index = 1, required = true, metaVar = "dir", usage = "destination repository")
  private File destGitDir;

  @Override
  protected void run() throws Exception {
    final List<RevObject> toCopy = new LinkedList<RevObject>();

    toCopy.add(baseCommit);
    toCopy.add(baseCommit.getTree());

    final TreeWalk tw = new TreeWalk(db);
    tw.reset();
    tw.addTree(baseCommit.getTree());

    while (tw.next()) {
      switch (tw.getFileMode(0).getObjectType()) {
        case Constants.OBJ_TREE:
          toCopy.add(argWalk.lookupTree(tw.getObjectId(0)));
          tw.enterSubtree();
          break;
        default:
          break;
      }
    }

    final Repository destdb = new Repository(destGitDir);
    final PackWriter packer = new PackWriter(db, new TextProgressMonitor());
    packer.preparePack(toCopy.iterator());
    final String packName = "pack-" + packer.computeName();
    final File packDir = new File(destdb.getDirectory(), "objects/pack");
    final File packPath = new File(packDir, packName + ".pack");
    final File idxPath = new File(packDir, packName + ".idx");

    if (packPath.exists() && idxPath.exists())
      throw die(packPath.getName() + " already exists.");

    {
      final BufferedOutputStream os =
          new BufferedOutputStream(new FileOutputStream(packPath));
      packer.writePack(os);
      os.close();
      packPath.setReadOnly();
    }
    {
      final BufferedOutputStream os =
          new BufferedOutputStream(new FileOutputStream(idxPath));
      packer.writeIndex(os);
      os.close();
      idxPath.setReadOnly();
    }
  }
}
 
-- 
Shawn.
