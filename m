From: H Krishnan <hetchkay@gmail.com>
Subject: Using git-svn fetch after a directory change with rewrite-root
Date: Mon, 8 Aug 2011 08:56:31 +0530
Message-ID: <CANWsHyfHtr0EaJtNsDK9UTcmb_AbLg-1jUA-0uWJ-nEeNosb7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 05:26:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqGUG-0007Ds-TB
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 05:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418Ab1HHD0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 23:26:32 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:42858 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359Ab1HHD0c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 23:26:32 -0400
Received: by yie30 with SMTP id 30so672722yie.19
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 20:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=wcXvdfkH1UFIUyKIBZiQI657ZHAPTJuM9MzBarCCGfY=;
        b=T96gZ2ACIPniEaHlet0Eexuu/ngMJIfn7NDdwWbjwa4SC8jGba7gk7dAIIP0T/lrYg
         VSH87tccw0vdfghE9OILpLlHWfL9QZneRhQH1mGZ1ISjxnVB2/ScZ+bqodgfXc1CbjNE
         n+Sfl1FRs5M56hg50+8bOuN1Ck/c2a0Z6PYhc=
Received: by 10.150.214.21 with SMTP id m21mr5096199ybg.139.1312773991580;
 Sun, 07 Aug 2011 20:26:31 -0700 (PDT)
Received: by 10.150.53.16 with HTTP; Sun, 7 Aug 2011 20:26:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178936>

Hi,
We use git-svn to sync with SVN. We set the "rewrite-root" attribute
to a dummy URL as different people use different SVN mirrors to update
their git repository. Recently, the trunk directory in SVN was
renamed. After this, with git version 1.7.3 or later, we are not able
to fetch. We get an SVN error ("RA layer request failed: ...: 200
OK"). git version 1.7.0 seemed to work OK. On debugging further, I
found that in the following lines, $url has the rewrite-root prefix
whereas $gs->full_url has the actual url prefix and thus the "last if"
fails.

while (1) {
	# It is possible to tag two different subdirectories at
	# the same revision.  If the url for an existing ref
	# does not match, we must either find a ref with a
	# matching url or create a new ref by growing a tail.
	$gs = Git::SVN->init($u, $p, $repo_id, $ref_id, 1);
	my (undef, $max_commit) = $gs->rev_map_max(1);
	last if (!$max_commit);
	my ($url) = ::cmt_metadata($max_commit);
	last if ($url eq $gs->full_url);
	$ref_id .= '-';
}
print STDERR "Initializing parent: $ref_id\n" unless $::_q > 1;

I wonder if commit 3235b7053c45a734c1cdf9b117bda68b7ced29c9 handles
rewrite-root correctly. Should the comparison be made with
$gs->metadata_url instead of $gs->full_url?

H. Krishnan
