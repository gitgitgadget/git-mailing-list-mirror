From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: git-annotate efficiency
Date: Fri, 24 Feb 2006 13:00:24 -0500
Message-ID: <118833cc0602241000p4e4c8017u3e3afe76fbbd75a4@mail.gmail.com>
References: <118833cc0602240737i42acdc90sb8f93dde1a1bc035@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Feb 24 19:00:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FChEz-0002BD-TM
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 19:00:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWBXSA0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 13:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWBXSA0
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 13:00:26 -0500
Received: from pproxy.gmail.com ([64.233.166.181]:47905 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932406AbWBXSA0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 13:00:26 -0500
Received: by pproxy.gmail.com with SMTP id e30so438294pya
        for <git@vger.kernel.org>; Fri, 24 Feb 2006 10:00:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JfuGO34wQT54QgY8WFnJy1VpJki/OM+xbP+3E5NNFgkgE+ZeBcfddi+ovj5lSdUKGw1nY9a7sXiBaDOHLRvmyWatpNVyHTCK5EoL7OojAJzin4AavIuw3+IQ/XY+b5xBcNIpuuQ3umjv5TEHGnAwZ27FgevYNIb3aL+ebOA5vBQ=
Received: by 10.35.18.4 with SMTP id v4mr334710pyi;
        Fri, 24 Feb 2006 10:00:24 -0800 (PST)
Received: by 10.35.39.13 with HTTP; Fri, 24 Feb 2006 10:00:24 -0800 (PST)
To: "GIT Mailing List" <git@vger.kernel.org>
In-Reply-To: <118833cc0602240737i42acdc90sb8f93dde1a1bc035@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16721>

It looks like handle_rev is seeing the same revisions over and over again.
I don't know why that would be, but the following patch just skips dups.
I have no idea if it is right, though.

Morten


diff --git a/git-annotate.perl b/git-annotate.perl
index 3800c46..a5e2d86 100755
--- a/git-annotate.perl
+++ b/git-annotate.perl
@@ -117,7 +117,10 @@ sub init_claim {

 sub handle_rev {
        my $i = 0;
+       my %seen = ();
        while (my $rev = shift @revqueue) {
+               next if $seen{$rev};
+               $seen{$rev} = 1;

                my %revinfo = git_commit_info($rev);
