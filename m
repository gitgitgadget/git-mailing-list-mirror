From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH (WIP)] gitweb: Use Test::WWW::Mechanize::CGI to test gitweb output
Date: Sat, 14 Jun 2008 20:07:34 +0200
Message-ID: <200806142007.35288.jnareb@gmail.com>
References: <200806141447.28052.jnareb@gmail.com> <4853D84D.5010303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 20:11:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7aDT-0006U0-GY
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 20:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbYFNSKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 14:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753789AbYFNSJ7
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 14:09:59 -0400
Received: from ik-out-1112.google.com ([66.249.90.181]:60495 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbYFNSJl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 14:09:41 -0400
Received: by ik-out-1112.google.com with SMTP id c28so3448570ika.5
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=BLsOVhyDTBaBo4tB4OR8syJHjshADHj2n+/smZvgxnI=;
        b=xlrksEQhveSk62CaZdgnDPryja3OgkO6txZVi/fV0flaj63xY++on2HS16ioy4fIRi
         Z5oFY9R2ghOKaZFRoXMIMCQuv3dRssdUl+Rc3ZJ14F9DtAPQt93KtUELSv5C81gVrU1T
         w+Lrz/wS3JlvfXBetyi2+eRTrpJGTvZ4t2fTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BsFeMNEyhabB6WOyyJ8Zdcxt7nQE31Z4bffFCTiCZ7qaU04JorVscOulscK2N2Uh5J
         jj6FIvkjZZId2U0puPsFRWVSZquI9vwzVJ1j2Pct1C0SJ9ON5b8jeY1BiGJt/em9ac9M
         DdsrgkL3WrIAc7hW0oNZw5+ZVVIISDOXml7EU=
Received: by 10.210.133.19 with SMTP id g19mr4151509ebd.83.1213466979974;
        Sat, 14 Jun 2008 11:09:39 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.239.84])
        by mx.google.com with ESMTPS id g9sm7624569gvc.0.2008.06.14.11.07.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 11:07:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4853D84D.5010303@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85027>

Lea Wiemann wrote:
> Jakub Narebski wrote:
> >
> > NOTE: Currently test_external_without_stderr fails because when trying
> > to access URL for non-existent commit gitweb writes to STDERR; it is
> > not necessarily a bug because it is not written to web server logs
> 
> Without having looked at the cause of that, I think that gitweb should 
> not be writing stuff to stderr unless an internal or serious error 
> occurs; in particular trying to access invalid commits shouldn't cause 
> messages on stderr, only to log files if at all.

Actually it isn't gitweb (or Perl) writing to stderr, but git itself.
Somehow, at least for gitweb run as CGI script (and under legacy
mod_perl) with Apache 2 as web server this error message:
  fatal: bad revision 'non-existent'
doesn't land in web server logs (/var/log/httpd/error_log).  So it lands
in /dev/null when running gitweb as web script, so it was deemed not
important (also fixing this is not very easy, as you can read below).

t/t9500-gitweb-standalone-no-errors.sh considers as errors only those
error message which would make it into web server logs, see gitweb_run()
function there.  This catches compilation errors.


Fixing this is not that simple.  There is no option to git-rev-list
to not write any output to stderr (no, '--quiet' is about something
else), and I'd rather not lose all advantages of list (shell-less)
form of magical "|-" open only for "2>/dev/null" redirection as
in git_object subroutine in gitweb.

Perhaps it could be solved in Git.pm, and when gitweb is rewritten
to use "use Git" (and global $repo object instead of global $git_dir
variable) it would automatically fix it (using Git.pm would have
the advantage of making gitweb more portable, I think - to ActiveState
broken Perl implementation, with broken magic "|-" open).

Or git-rev-list, or even git wrapper itself, could acquire option to
redirect all stderr to dev null... I think adding it in git wrapper
would be even better; simply change "warning" and "die" to null
functions (I was even thinking about doing that...).

> That said, as long as it isn't fixed, here's my workaround to 
> temporarily discard stderr (from my t/t9710/test.pl):
> 
> our $old_stderr;
> sub discard_stderr {
>          open our $old_stderr, ">&", STDERR or die "cannot save STDERR";
>          close STDERR;
> }
> sub restore_stderr {
>          open STDERR, ">&", $old_stderr or die "cannot restore STDERR";
> }
> 
> It works on Unix, but I don't know about other platforms.

Thanks.

> > +cat >gitweb_config.perl <<EOF
> > [...]
> > +our \$GIT = "git";
> 
> t9500 seems to be doing the same(?) thing, but this somehow doesn't work 
> with your t9503 test:

It should work.  test-lib.sh sets up $PATH to have 'git' binary (just
compiled git binary) in it...

> $ git     # no git in PATH to make sure it picks up the right git binary
> bash: git: command not found
> $ ./t9500-gitweb-standalone-no-errors.sh | grep passed
> * passed all 75 test(s)
> $ ./t9503-gitweb-Mechanize.sh -v
> [...]
> 	gitweb.perl: Can't exec "git": No such file or directory at 
> /home/lea/source/git/fresh-git/gitweb/gitweb.perl line 380.

...and it would be very strange for t9500 to pass, but t9503 do not
pass.  (Of course both tests passes at my computer, otherwise
I wouldn't send this patch in current form).

Hmmm... perhaps $PATH doesn't get passed down... strange.


But thanks to your report I have found bug in gitweb.  I have changed
t/t9503-gitweb-Mechanize.sh... 

diff --git a/t/t9503-gitweb-Mechanize.sh b/t/t9503-gitweb-Mechanize.sh
index 5df22c4..a5be275 100755
--- a/t/t9503-gitweb-Mechanize.sh
+++ b/t/t9503-gitweb-Mechanize.sh
@@ -92,7 +92,7 @@ cat >gitweb_config.perl <<EOF
 # gitweb configuration for tests
 
 our \$version = "current";
-our \$GIT = "git";
+our \$GIT = "$safe_pwd/../../git";
 our \$projectroot = "$safe_pwd";
 our \$project_maxdepth = 8;
 our \$home_link_str = "projects";

...and found out that gitweb doesn't like when $GIT contains spaces
in _one_ place: finding git version.  It should be
 
 our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";

with $GIT quoted.  (Patch will be send shortly).


So better solution would be

diff --git a/t/t9503-gitweb-Mechanize.sh b/t/t9503-gitweb-Mechanize.sh
index 5df22c4..a5be275 100755
--- a/t/t9503-gitweb-Mechanize.sh
+++ b/t/t9503-gitweb-Mechanize.sh
@@ -92,7 +92,7 @@ cat >gitweb_config.perl <<EOF
 # gitweb configuration for tests
 
 our \$version = "current";
-our \$GIT = "git";
+our \$GIT = "$GIT_EXEC_PATH/git";
 our \$projectroot = "$safe_pwd";
 our \$project_maxdepth = 8;
 our \$home_link_str = "projects";


Does it works for you?
-- 
Jakub Narebski
Poland
