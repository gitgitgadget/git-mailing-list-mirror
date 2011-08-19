From: Thomas Robinson <trobinson@systemsbiology.org>
Subject: BUG: Inconsistent handling of challenge-on-commit in git-svn
Date: Fri, 19 Aug 2011 14:29:17 -0700
Message-ID: <4E4ED5AD.6000209@systemsbiology.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 23:35:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuWjC-0000HN-Sg
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 23:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762Ab1HSVfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 17:35:42 -0400
Received: from exprod7og110.obsmtp.com ([64.18.2.173]:58362 "EHLO
	exprod7og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004Ab1HSVfl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 17:35:41 -0400
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Aug 2011 17:35:40 EDT
Received: from mail-pz0-f46.google.com ([209.85.210.46]) (using TLSv1) by exprod7ob110.postini.com ([64.18.6.12]) with SMTP
	ID DSNKTk7XLKgEW+8wATG5To7+Tnv3b4BDoXic@postini.com; Fri, 19 Aug 2011 14:35:40 PDT
Received: by mail-pz0-f46.google.com with SMTP id 32so5856528pzk.19
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 14:35:40 -0700 (PDT)
Received: by 10.143.69.1 with SMTP id w1mr95186wfk.302.1313789359176;
        Fri, 19 Aug 2011 14:29:19 -0700 (PDT)
Received: from koala.local (pix39.systemsbiology.net [209.124.189.39])
        by mx.google.com with ESMTPS id g4sm2624164pbj.73.2011.08.19.14.29.18
        (version=SSLv3 cipher=OTHER);
        Fri, 19 Aug 2011 14:29:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.9) Gecko/20100825 Thunderbird/3.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179727>

Additionally reporting the issue here, because git-svn also fails to 
handle this issue gracefully. Worry not; this is something that SVN 
should fix upstream as well.

I've noticed that, when a conflicting user is specified in what should 
be an invalidatable portion of SVN's authentication cache, git-svn will 
fail the same obscure error thrown by the SVN binary:

$ git svn dcommit
Committing to https://rf-ace.googlecode.com/svn/trunk ...
URL access forbidden for unknown reason: access to 
'/svn/!svn/act/b039ca42-f359-41d0-9523-bbbca5266026' forbidden at 
/usr/local/git/libexec/git-core/git-svn line 4472


The difference, of course, is that explicitly passing my credentials via 
--username appears to be silently ignored, such that my workaround 
posited to the SVN team below *doesn't* work in Git SVN.

This, of course, contradicts the information I could find while 
searching for the problem, notably here:
http://groups.google.com/group/google-code-hosting/browse_thread/thread/72b6875507dca1d1


As such, it is possible that the cache challenge is spuriously taking 
precedence over credentials specified by --username, causing an 
irresolvable conflict until a user's SVN cache is cleared. This is, 
needless to say, less than ideal.


My original bug report to the SVN user community follows below. Thank 
you for taking the time to read this.

- Tom Robinson

---
The following is a bug report for triage and review. I've been unable to 
locate an adequate fix or discussion for this issue; however, I have 
found an acceptable workaround.


When built on OSX, SVN versions 1.6.16 (r1073529) and 1.6.17 (r1128011) 
appear to handle authentication challenges on commit in a non-robust manner.

The testing that follows is against a Google Code project that I 
currently maintain code for, which may be found here:
http://code.google.com/p/rf-ace/


Here is a sparse log of a fresh checkout and commit using SVN version 
1.6.16 (r1073529) on OSX. All builds are inclusive of ra-neon:

$ svn checkout https://rf-ace.googlecode.com/svn/trunk/ rf-ace.svn 
--username trobinson@systemsbiology.org
... file data ...
Checked out revision 265.

$ cd rf-ace.svn
... make some changes to existing files ...

$ svn commit
... write the log in my default editor ...

"svn-commit.tmp" 35L, 1392C written
svn: Commit failed (details follow):
svn: access to '/svn/!svn/act/c23cbe26-fda3-46d6-a358-d1d20738c4bf' 
forbidden
svn: Your commit message was left in a temporary file:
svn: '/path/to/my/repo/scrubbed/from/this/report/rf-ace.svn/svn-commit.tmp'

This same behavior exhibits in 1.6.17 (r1128011), and when a log message 
is given using -m.



Here is an approximately equivalent session using SVN version 1.6.11 
(r934486) in CentOS 6:

$ svn checkout https://rf-ace.googlecode.com/svn/trunk/ rf-ace 
--username trobinson@systemsbiology.org
... file data ...
Checked out revision 265.

$ cd rf-ace
... make some changes to existing files ...

$ svn up
... file data ...
Checked out revision 269.

$ svn commit -m "Irrelevant log message you can find in r270 of rf-ace"
Authentication realm: <https://rf-ace.googlecode.com:443> Google Code 
Subversion Repository
Password for 'trobinso':
[In which I press enter here to fall back to explicit Username 
specification]

Authentication realm: <https://rf-ace.googlecode.com:443> Google Code 
Subversion Repository
Username: trobinson@systemsbiology.org
Password for 'trobinson@systemsbiology.org': [My correct password is 
entered here]
Sending        test/argparse_test.hpp
Transmitting file data .
-----------------------------------------------------------------------
ATTENTION!  Your password for authentication realm:

    <https://rf-ace.googlecode.com:443> Google Code Subversion Repository

can only be stored to disk unencrypted!  You are advised to configure
your system so that Subversion can store passwords encrypted, if
possible.  See the documentation for details.

You can avoid future appearances of this warning by setting the value
of the 'store-plaintext-passwords' option to either 'yes' or 'no' in
'/my/home/directory/.subversion/servers'.
-----------------------------------------------------------------------
Store password unencrypted (yes/no)? yes [I know, I know. See my notes 
below.]

Committed revision 270.


Note that on personal dev boxes, authentication information has been 
stored locally in ~/.subversion (which, I note as an aside, is something 
I only do with definedly-insecure passwords like those automatically 
generated by Google Code on machines that are for internal development 
only). This, too, may cause the issue.

My workaround, of course, is obvious. For all versions of SVN, 
specifying the username explicitly (a la "--username 
trobinson@systemsbiology.org") immediately follows up with a challenge 
for my password. I have not verified if this resolves future commit 
attempts.


The catalyst for the issue is Google's recent transition of Google Code 
login system to that of Google Accounts. In this case, for conflicting 
users, the issue only exposed itself when we cut back over to our 
original usernames, and I would speculate this occurs if (and only if)
the same username is specified with an alternate password (as mine was).

Thus, we have a compelling case for potentially spurious handling of 
conflicting user credentials, as may well expose themselves in the 
migration of Google Code SVN repositories. In which I would speculate 
that the right approach would be to invalidate the cached copy of the 
user's credentials and re-challenge both the username and the password. 
Ideally, this behavior would be grafted into a configuration value, 
should it not already exist.


As you might expect, searching for this information is nigh-impossible 
for this exact edge condition, and you will probably receive several 
queries of a similar nature as Google continues to transition accounts 
with access to Google Code. Thus my posting of this bug report: assuming 
my hypothesis is correct, it's a case of inconsistent credential 
handling that results in a non-intuitive error message. As above, this 
would be better handled by configurable invalidation of the user's 
cached credentials.

Thus concludes my report. Please copy me on any mail you expect for me 
to see, as I am not a subscriber to this list.


Best regards,
- Tom Robinson
