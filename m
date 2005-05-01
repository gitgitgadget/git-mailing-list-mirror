From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: graphing commit trees
Date: Sun, 1 May 2005 22:01:07 +0200
Message-ID: <20050501200107.GA32703@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 01 21:56:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSKXC-00046q-CW
	for gcvg-git@gmane.org; Sun, 01 May 2005 21:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbVEAUBR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 16:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbVEAUBR
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 16:01:17 -0400
Received: from alephnull.demon.nl ([212.238.201.82]:971 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S262643AbVEAUBI
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 1 May 2005 16:01:08 -0400
Received: by xi.wantstofly.org (Postfix, from userid 500)
	id 394C32B0EC; Sun,  1 May 2005 22:01:07 +0200 (MEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi!

As a 5-minute hack to see how easy it'd be to create trees from commit
objects: the attached perl script creates a file suitable for feeding
to dot/dotty from the graphviz suite.  Example graph at:

	http://www.liacs.nl/~buytenh/graph_42d4dc3f4e1ec1396371aac89d0dccfdd977191b.png

Warning: big image (2746x41363), many apps can't display it properly.
(mozilla gives an error, eog shows only the top 32768 pixel rows, gimp
seems to work.)


--L


#!/usr/bin/perl

my %processed;

sub traverse {
        my $commit = shift;
        my $parent;
        my @parents;

        return if (defined $processed{$commit});
        $processed{$commit} = "";

        @parents = split(" ", `git-cat-file commit $commit | grep "^parent " | awk '{print \$2}'`);

        foreach $parent (@parents) {
                print "\"$parent\" -> \"$commit\"\n";
                traverse($parent);
        }
}

sub mk_graph {
        my $root = shift;

        print "digraph blah_$root {\n";
        traverse($root);
        print "}\n";
}

$root = `cat .git/HEAD`;
chomp $root;

mk_graph($root);


