From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git-cvsimport: $cvs->file() fails silently
Date: Tue, 1 Nov 2005 14:22:37 +1300
Message-ID: <46a038f90510311722y56eadd3bj1ae53db05c496c67@mail.gmail.com>
References: <46a038f90510262123y4f56cf7v5494b391394ac648@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Nov 01 02:24:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWkrJ-00058g-5U
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 02:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbVKABWi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 20:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbVKABWi
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 20:22:38 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:34368 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964909AbVKABWh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 20:22:37 -0500
Received: by xproxy.gmail.com with SMTP id i30so1151455wxd
        for <git@vger.kernel.org>; Mon, 31 Oct 2005 17:22:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qosjfZ4dYxlc9h52tac8fD7HzSEiztuMa8TrfyC9p9Ad2Soj577EDU9JMx6hI39RxMkBb90QYfejRohkQzeo88tsBrYj7q/Hwmlz2RLskynE08cL3DIlruzW2FHAuFdqIVGfwmHLe6EDzM92txyK38vccqsYJiEssVgvnSXzxw4=
Received: by 10.64.10.9 with SMTP id 9mr702319qbj;
        Mon, 31 Oct 2005 17:22:37 -0800 (PST)
Received: by 10.64.232.18 with HTTP; Mon, 31 Oct 2005 17:22:37 -0800 (PST)
To: Matthias Urlichs <smurf@smurf.noris.de>,
	Sven Verdoolaege <skimo@kotnet.org>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <46a038f90510262123y4f56cf7v5494b391394ac648@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10914>

On 10/27/05, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> There _must_ be one place that we're missing but I just can't
> see it.

Got some more info on this. The output of cvsimport when this happens
looks like this:

Read from remote host cvs.sourceforge.net: Connection reset by peer
Read from remote host cvs.sourceforge.net: Connection reset by peer
Update course/enrol.php:  bytes
Use of uninitialized value in split at
/home/martin/local/git/git-cvsimport line 362.
Update lang/en/moodle.php: 66792 bytes
Tree ID ef11ad5a0cf917e98bc477837de1b3f587e12027
Parent ID e972b3a28e1c4802fc5af6a996164c93fb4f3e53
Committed patch 20143 (MOODLE_15_STABLE 2005-10-31 20:31:57)
Commit ID 95a748b0d9cd6dc74e65497561514fa5858c149c

Around line 335  $res = $self->_line($fh); is returning '', which is
defined but otherwise empty. I've patched cvsimport thus to try and
catch this kind of error:

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index bbb83fb..f594df3 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -337,6 +337,10 @@ sub file {
        }
        close ($fh);

+       if ($res eq '') {
+           die "Looks like the server has gone away during the transaction!";
+       }
+
        return ($name, $res);
 }

@@ -764,6 +768,9 @@ while(<CVS>) {
                my $rev = $3;
                $fn =~ s#^/+##;
                my ($tmpname, $size) = $cvs->file($fn,$rev);
+               if ($size eq '') {
+                       die "Should not happen! Something went wrong
with the remote connection";
+               }
                if($size == -1) {
                        push(@old,$fn);
                        print "Drop $fn\n" if $opt_v;

Now, I'm sure we can catch it in the "right" place, but I'm not sure
where that is.

cheers,


martin
