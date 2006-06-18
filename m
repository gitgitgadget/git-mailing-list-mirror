From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: parsecvs leaks and optimizations
Date: Sun, 18 Jun 2006 01:15:10 -0400
Message-ID: <9e4733910606172215t2d1e987g207d1d394a6f92b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jun 18 07:15:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frpd4-0002fJ-4o
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 07:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWFRFPN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 01:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWFRFPN
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 01:15:13 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:13607 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932098AbWFRFPL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 01:15:11 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1423767nze
        for <git@vger.kernel.org>; Sat, 17 Jun 2006 22:15:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eY9AXn+Q+upJNEZgfhlZ174/d0Ts62X8jtxa9QosIGp8tA/IkddOyVGLs7l8u0NrEJsPHw6Aou7w6pcjTtEKaJRW02lvlWLH7CS2XVQum72eDNUadJ5CgWZwRhMgWbEwvyTTU4GWvF9kmGAptkcEjtmDPUcMbISe6Vueh5cdyYY=
Received: by 10.36.252.12 with SMTP id z12mr2511027nzh;
        Sat, 17 Jun 2006 22:15:11 -0700 (PDT)
Received: by 10.36.37.5 with HTTP; Sat, 17 Jun 2006 22:15:10 -0700 (PDT)
To: "Keith Packard" <keithp@keithp.com>, git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22051>

#1) the seen field is wrapping, char is too small.

#2)
static void
rev_tag_search (rev_ref **tags, int ntag, rev_ref *tag, rev_list *rl)
{
    rev_commit	**commits = calloc (ntag, sizeof (rev_commit *));
    int		n;

    for (n = 0; n < ntag; n++)
	commits[n] = tags[n]->commit;
    ntag = rev_commit_date_sort (commits, ntag);

    tag->parent = rev_branch_of_commit (rl, commits[0]);
    if (tag->parent)
	tag->commit = rev_commit_locate (tag->parent, commits[0]);
    if (!tag->commit) {
	tag->commit = rev_commit_build (commits, ntag);
>>> everything from here is leaking
    }
    free (commits);
}

#3) cvs_find_symbol is very hot, probably should be a hash. Mozilla
has thousands of symbols.

#4) rcs2git is n-squared and parses the file over and over to get the
revs. The n-squared really hurts when a ,v file is 45MB. A single pass
algorithm would work wonders. Or at least cache the offsets to the
revs as they are found. Can the revs be written straight to a pack
file and then connected up with a tree later?

#5) This small group fails, parsecvs sends a null to git. Git dies.
/home/mozcvs/mozilla/Makefile.in,v
/home/mozcvs/mozilla/.cvsignore,v
/home/mozcvs/mozilla/LEGAL,v
/home/mozcvs/mozilla/LICENSE,v
/home/mozcvs/mozilla/README.txt,v
/home/mozcvs/mozilla/aclocal.m4,v
/home/mozcvs/mozilla/camino.mk,v

#6) comparing versions is very hot. Could versions be encoded into a
long or long long for more efficient comparisons? Packed bit field
unioned with long. Checks on initial parsing to make sure fields don't
over flow.

I'm working on some global analysis to try and track down the missing
branch tags but it is very slow going. It would be better to speed up
the basic process first.

-- 
Jon Smirl
jonsmirl@gmail.com
