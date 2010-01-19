From: James Pickens <jepicken@gmail.com>
Subject: [BUG] Git 1.6.6 can't clone tags after filter-branch
Date: Tue, 19 Jan 2010 15:05:21 -0700
Message-ID: <885649361001191405x7a4ca1a2i153ad952c7d41ad7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git ML <git@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Jan 19 23:05:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXMCp-0006xQ-9S
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 23:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398Ab0ASWFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 17:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754233Ab0ASWFm
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 17:05:42 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:43086 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474Ab0ASWFm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 17:05:42 -0500
Received: by ywh12 with SMTP id 12so2938462ywh.21
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 14:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=9/Hrnxh9nl8m/cX4jJStUF4rhZuye5AfzE+5w03rZPk=;
        b=Yh1PZvQ+V1M9V5uNnomUD7yfIXaKdC9DXk6YXFFaN4gtONQVZl7Upuz2yZyZ1WOSvQ
         VTnt2p+NXo4J0P15U5cuRDItevaEve/SBxqLDWzwV9oSP7W0TO0roQVG4kxeCzueESaz
         /QfKl2GPF/EBzW6Wl+l++eteN95R3YbR3GWNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=H3GpVTtlw6GJEC5WfkQqaozbybfcklnkRkk2rrkzQFBtnXgPtKs201sc11aWm3fmPe
         EI0HwZZ75GO5loq2lmh55yZeABJ1TacXm1wWsygadBeYT39RKzt6onsDY8qkNwEp8BIq
         pxeKYWzX++W65hNXy7o2NcmdmK+barmctD3K8=
Received: by 10.150.237.8 with SMTP id k8mr3132261ybh.98.1263938741311; Tue, 
	19 Jan 2010 14:05:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137497>

Hi,

This series of commands:

  git init
  touch file1
  git add file1
  git commit -m 1
  echo >> file1
  touch file2
  git add file1 file2
  git commit -m 2
  git tag -m 'mytag' mytag
  git filter-branch --index-filter 'git rm --cached --ignore-unmatch file2' \
    --tag-name-filter cat -f -- --all
  git clone file://$PWD temp

Results in an error from the clone command:

  error: refs/tags/mytag does not point to a valid object!

The clone command exits with zero status, but the new repo doesn't contain
the tag 'mytag'.

Version 1.6.2.5 did not have this problem.  It bisects to:

  commit 5bdc32d3e50d8335c65e136e6b5234c5dd92a7a9
  Author: Nicolas Pitre <nico@fluxnic.net>
  Date:   Fri Sep 25 23:54:42 2009 -0400

      make 'git clone' ask the remote only for objects it cares about

James
