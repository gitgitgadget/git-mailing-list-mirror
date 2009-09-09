From: "Adam W. Hawks" <awhawks@writeme.com>
Subject: [ JGIT ] incompatiblity found in DirCache
Date: Wed, 09 Sep 2009 14:55:39 -0400
Message-ID: <4AA7FA2B.4090707@writeme.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 09 20:56:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlSKq-0003V1-Uu
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 20:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbZIISzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 14:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752576AbZIISzn
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 14:55:43 -0400
Received: from outbound1-1.us4.outblaze.com ([208.36.123.129]:51873 "EHLO
	outbound1-1.us4.outblaze.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752007AbZIISzm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Sep 2009 14:55:42 -0400
Received: from smtp1.us4.outblaze.com (ws1-8.us4.outblaze.com.int [192.168.11.70])
	by outbound1-1.us4.outblaze.com (Postfix) with SMTP id 604537A0DA8
	for <git@vger.kernel.org>; Wed,  9 Sep 2009 18:55:45 +0000 (GMT)
Received: (qmail 18473 invoked from network); 9 Sep 2009 18:49:28 -0000
Received: from unknown (HELO ?192.168.0.4?) (awhawks:writeme.com@mail.com@24.74.41.120)
  by ws1-8.us4.outblaze.com with SMTP; 9 Sep 2009 18:49:27 -0000
User-Agent: Thunderbird 2.0.0.22 (X11/20090605)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128075>

When using the DirCache interface to the index you can create a invalid/corrupt tree for git 1.6.5.

The problem seems to be you can add a path to the index that starts with a "/" and DirCache creates a entry with a mode but no path.
This causes git 1.6.5 to fail with a corrupt tree.

The following code will create the problem

import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

import org.spearce.jgit.dircache.DirCache;
import org.spearce.jgit.dircache.DirCacheBuilder;
import org.spearce.jgit.dircache.DirCacheEntry;
import org.spearce.jgit.lib.Commit;
import org.spearce.jgit.lib.FileMode;
import org.spearce.jgit.lib.ObjectId;
import org.spearce.jgit.lib.ObjectWriter;
import org.spearce.jgit.lib.PersonIdent;
import org.spearce.jgit.lib.RefUpdate;
import org.spearce.jgit.lib.Repository;
import org.spearce.jgit.lib.RefUpdate.Result;

public class BuildTest
{
	private Repository db;
	
	public static void main(String[] args)
	{
		BuildTest bt = new BuildTest();
		bt.doit();
	}
	
	public void doit()
	{		
		Date when = Calendar.getInstance().getTime();
		File gitDir = new File("gitProblem/.git");
		gitDir.mkdirs();
		try
		{
			db = new Repository(gitDir);
			db.create(true);
			DirCache dirc = DirCache.newInCore();
			DirCacheBuilder dcb = dirc.builder();
			byte[] data = "Some File data".getBytes();
			ObjectWriter ow = new ObjectWriter(db);
			ObjectId dataId = ow.writeBlob(data);
			DirCacheEntry newEntry = new DirCacheEntry("/someDir/someFile");
			newEntry.setAssumeValid(false);
			newEntry.setFileMode(FileMode.REGULAR_FILE);
			newEntry.setLastModified(when.getTime());
			newEntry.setLength(data.length);
			newEntry.setObjectId(dataId);
			dcb.add(newEntry );
			dcb.finish();
			dirc = dcb.getDirCache();
			PersonIdent pi = new PersonIdent("someonw","someone@somewhere",when,TimeZone.getDefault());
			ObjectId tree = dirc.writeTree(new ObjectWriter(db));
			Commit commit = new Commit(db);
			commit.setAuthor(pi);
			commit.setCommitter(pi);
			commit.setMessage("This causes a corrupt tree");
			commit.setTreeId(tree);
			commit.commit();
			ObjectId cid = commit.getCommitId();
			RefUpdate ru = db.updateRef("refs/heads/master");		
			ru.setExpectedOldObjectId(ObjectId.zeroId());
			ru.setNewObjectId(cid);
			ru.setRefLogIdent(pi);
			ru.setRefLogMessage("some reflog message", true);
			Result result = ru.update();
			System.out.println("Result = "+result.toString());
		}
		catch (IOException e)
		{
			System.out.println(e);
			e.printStackTrace();
			System.exit(1);
		}
	}	
}
