From: Geert Bosch <bosch@adacore.com>
Subject: Using git to manage multiple SVN repositories
Date: Tue, 30 Jun 2009 10:29:16 -0400
Message-ID: <DB544A72-AD2A-4E7D-8421-6B72A4DECF3E@adacore.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 30 17:00:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward2.uio.no ([129.240.10.71])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLemN-0002T1-Di
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 16:57:51 +0200
Received: from exim by mail-out2.uio.no with local-bsmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLeUx-0007bO-Oz
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 16:39:51 +0200
Received: from mail-mx6.uio.no ([129.240.10.47])
	by mail-out2.uio.no with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLeUx-0007bL-O0
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 16:39:51 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx6.uio.no with esmtp  (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLeUw-0001AP-3U
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 16:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbZF3Oi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 10:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752980AbZF3Oi4
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 10:38:56 -0400
Received: from rock.gnat.com ([205.232.38.15]:33304 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752828AbZF3Oiz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 10:38:55 -0400
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jun 2009 10:38:55 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 5C1A72BAAB3
	for <git@vger.kernel.org>; Tue, 30 Jun 2009 10:29:16 -0400 (EDT)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bEq6KZc9n+WO for <git@vger.kernel.org>;
	Tue, 30 Jun 2009 10:29:16 -0400 (EDT)
Received: from potomac.gnat.com (potomac.gnat.com [205.232.38.115])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTPSA id 41DCF2BAAAD
	for <git@vger.kernel.org>; Tue, 30 Jun 2009 10:29:16 -0400 (EDT)
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3, uiobl=NO, uiouri=_URIID_)
X-UiO-Scanned: D6F904AF2BB09DB43DE2AF6FFC7A507FE7284948
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 150 total 2547828 max/h 849 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122517>

Hi all,

For my work I have to deal with various related large Subversion
repositories with more than 15 years of history that need
to be kept mostly in sync, but with varying layout.

As expected, git turns out to be a truly excellent tool for this
job. My workflow seems very non-standard though, so I'd like to
share it to maybe help others in similar situations and solicit
feedback to fine-tune my setup. Also, I have the suspicion that
I should probably use submodules for some of this, but they
don't really seem to fit well.

My goal is to polish this workflow, so it's usable even by
those suffering from prolonged exposure to RCS and CVS.

Repositories:

   -- Public Subversion repository
   public/module1/...
      :   module2/...
      :   moduleX/ourstuff-public/morestuff-public


   -- Company private Subversion repository
   private/ourstuff-private
      :   /morestuff-private
      :   /our-other-stuff

In my working tree, I do a svn clone of the entire
public repository:

   %git svn clone public:/public

Then, I put our private copy of moduleX inside:
   %git svn clone private:/private/ourstuff-private
   %rm -rf public/moduleX/ourstuff-public
   %mv private/ourstuff-private public/moduleX/ourstuff-public

Finally, as ourstuff-private does not include morestuff-private,
I clone that part to and put it inside in a 3rd nested git repository:

   % git svn clone private:/private/morestuff-private
   % mv private/morestuff-private public/moduleX/ourstuff-public/ 
morestuff-public

Now, I can go to the toplevel public and do a
   public% git checkout -f

This will bring in all upstream changes. Then, going to directory
public/moduleX/ourstuff-public, I can easily see the changes done
upstream and (using git gui) commit those changes acceptable in
our private repository and work on reducing the set of differences.

When that's done, do a checkout -f in the same ourstuff-public
directory (which contains the git svn clone of ourstuff-private)
will discard any unmerged changes. Going back to the toplevel
public directory, will now let me pick any of our private changes
that are acceptable into the public Subversion repository.

For files in the ourstuff-public directory that we don't want
(like ChangeLog files) I put a .gitignore in ourstuff-public.
For private files that we intend to keep private, I add a
.gitignore in public/moduleX, containing lines of the form
ourstuff-public/topsecretfile. Differences that I'll have to
carry around for a long time, I commit locally.

Using "git svn rebase" I can pull in any new development in either
the public or private Subversion repositories. This workflow is already
light years ahead of anything I could hope to achieve with Subversion.
However, the one big thing I miss is being able to do a commit in the
outermost git repository (the clone of the public Subversion repo),  
which
includes the current heads of all the enclosed repositories.

It seems this is something that should be doable with git submodules,
but I'm not quite sure how, without messing up my somewhat non-standard
setup. Any hints/tips/comments are appreciated.

   -Geert
