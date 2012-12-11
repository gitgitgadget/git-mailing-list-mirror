From: Matthew Daley <mattjd@gmail.com>
Subject: Re: [PATCH] gitweb: Sort projects with undefined ages last
Date: Tue, 11 Dec 2012 23:56:07 +1300
Message-ID: <1355223367-5894-1-git-send-email-mattjd@gmail.com>
References: <7vip8actz3.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Matthew Daley <mattjd@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 11 11:55:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiNV2-0004XC-E5
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 11:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027Ab2LKKz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 05:55:28 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:51811 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab2LKKz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 05:55:27 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so1654210dak.19
        for <git@vger.kernel.org>; Tue, 11 Dec 2012 02:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UwxeaEOwMg8gEMHd38ANnNt2wkgO/AVdqOMX+koL46E=;
        b=zl0DrFSei2O2BVIr+V7zdPH/umHP0pMzVThvZhydj2yEGOOu6vSI6oItGXNfrO7C6V
         BsKYDIWyu6CpqQhENnGYqT777kG7ycr/ICWSEpBdx7edvkdMjVEG3mzrSY3kVOuHuHA6
         W07TnwLqxJ+22ZkOOZ4fFCi+UAz2zdOrp6urfUhx1/DLW1tdlYVBsZpYG6n3dz9+jR2o
         HVKF3k8UzDuEyMLuLsEaPHRLmeyFpD+e8edI/pOtVUnkm8SJ4gr/FJbqwKCxSRlF1XE4
         3TmgMgLfFg2JxvzezBME2zmau/0e+E5tUFRxLgWyX08dQj+IdEAccmloSUyYamrGRthF
         eOGQ==
Received: by 10.66.79.133 with SMTP id j5mr43704286pax.51.1355223326707;
        Tue, 11 Dec 2012 02:55:26 -0800 (PST)
Received: from morphism.xen.prgmr.com (morphism.xen.prgmr.com. [71.19.145.114])
        by mx.google.com with ESMTPS id vs3sm13573366pbc.61.2012.12.11.02.55.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Dec 2012 02:55:25 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <7vip8actz3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211286>

On Mon, Dec 10, 2012 at 7:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Yeah, it could be argued that in a very minor corner case showing
> new and empty ones at the top might attract more attention to them,
> but new and empty ones can stay inactive, so this change would be an
> overall improvement for these two sites.  An alternative could be to
> give the mtime of the git directory to the age field if there is no
> commits in the repository, to sink the empty and inactive ones to
> the bottom quickly while showing newly created ones at the top, but
> it shouldn't make any practical difference.

Agreed.

> Two observations:
>
>  * This iterates over the same @$projlist twice with grep, with one
>    "defined" and the other "!defined", which may risk these two
>    complementary grep conditions to go out of sync (it also may
>    affect performance but that is a lessor issue).
>
>    An alternative may be to change the expression used inside sort()
>    to treat an undef as if it were a very large value, something
>    like:
>
>         sort {
>                 defined $a->{$oi->{'key'}}
>                 ? (defined $b->{$oi->{'key'}}
>                   ? ($a->{$oi->{'key'}} <=> $b->{$oi->{'key'}})
>                   : -1)
>                 : (defined $b->{$oi->{'key'}} ? 1 : 0);
>         }
>
>  * This "sort undefs at the end is better than at the beginning" is
>    good only for the "age" field, and we wouldn't know if we would
>    add other keys for which it may be better to sort undef at the
>    beginning.  The order_info{} currently has only one field of the
>    'num' type, so this is not an immediate issue, but in order to
>    future proof, it may make sense to rewrite the sort_projects_list
>    function to map the order field name to a function given to sort,
>    e.g.
>
>         my %order_sort = (
>                 project => sub { $a->{'path'} cmp $b->{'path'} },
>                 descr => sub { $a->{'descr_long'} cmp $b->{'descr_long'} },
>                 owner => sub { $a->{'owner'} cmp $b->{'owner'} },
>                 age => sub { ... the num cmp with undef above ... },
>         );
>         if (!exists $order_sort{$order}) {
>                 return @$projlist;
>         }
>         return sort $order_sort{$order} @$projlist;
>
> I am not sure the second one is worth it, though.

I thought about both of those variants as well. What about this:

-- >8 --
Subject: [PATCH] gitweb: Sort projects with undefined ages last

Sorting gitweb's project list by age ('Last Change') currently shows
projects with undefined ages at the head of the list. This gives a less
useful result when there are a number of projects that are missing or
otherwise faulty and one is trying to see what projects have been
updated recently.

Fix by sorting these projects with undefined ages at the bottom of the
list when sorting by age.

Signed-off-by: Matthew Daley <mattjd@gmail.com>
---
 gitweb/gitweb.perl |   35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0f207f2..656b324 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5528,23 +5528,30 @@ sub fill_project_list_info {
 
 sub sort_projects_list {
 	my ($projlist, $order) = @_;
-	my @projects;
 
-	my %order_info = (
-		project => { key => 'path', type => 'str' },
-		descr => { key => 'descr_long', type => 'str' },
-		owner => { key => 'owner', type => 'str' },
-		age => { key => 'age', type => 'num' }
-	);
-	my $oi = $order_info{$order};
-	return @$projlist unless defined $oi;
-	if ($oi->{'type'} eq 'str') {
-		@projects = sort {$a->{$oi->{'key'}} cmp $b->{$oi->{'key'}}} @$projlist;
-	} else {
-		@projects = sort {$a->{$oi->{'key'}} <=> $b->{$oi->{'key'}}} @$projlist;
+	sub order_str {
+		my $key = shift;
+		return sub { $a->{$key} cmp $b->{$key} };
 	}
 
-	return @projects;
+	sub order_num_then_undef {
+		my $key = shift;
+		return sub {
+			defined $a->{$key} ?
+				(defined $b->{$key} ? $a->{$key} <=> $b->{$key} : -1) :
+				(defined $b->{$key} ? 1 : 0)
+		};
+	}
+
+	my %orderings = (
+		project => order_str('path'),
+		descr => order_str('descr_long'),
+		owner => order_str('owner'),
+		age => order_num_then_undef('age'),
+	);
+
+	my $ordering = $orderings{$order};
+	return defined $ordering ? sort $ordering @$projlist : @$projlist;
 }
 
 # returns a hash of categories, containing the list of project
-- 
1.7.10.4
