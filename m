From: Tim Harper <timcharper@gmail.com>
Subject: surprising error message in parse_opt_with_commit
Date: Thu, 6 Aug 2009 13:27:25 -0600
Message-ID: <e1a5e9a00908061227n67a878f5tb2d5130582b4fd44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 21:27:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ8cz-0008As-OA
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 21:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756521AbZHFT1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 15:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756082AbZHFT1o
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 15:27:44 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:17623 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756018AbZHFT1o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 15:27:44 -0400
Received: by rv-out-0506.google.com with SMTP id f6so231846rvb.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 12:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=bTQ4/FgzcgWAhDNraJem0OXbzNqyX6EBIR67v4rytAo=;
        b=Dy2jRzKutIHg9RJEpisrDN5TcPM+RnzGQvd14UO6Jzjm+dBXpo8HBXGx9mRb5TgmpZ
         to/DodxcQ0JBoQtQIz2Pm/UJcDGUeK6Aq839JW/8KLBjj8ocE6K+JK+Rs1dF7reo9tV4
         uYxI7Kce0yoeRJVDyOvBClGlg/iBeCl7mQv4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=ix27SoNZCG1/1GVYgIA8H2ur+it7uW+Wp07B2gnKcSb04L0qpdGgRmHPMInk+gb1ty
         STZ0LmKqhen9qE2YcVnEH+qSiBbSJHw9UDlaaHCVy2SMgiHdx2Sq+V8uiu7KN0lkF6Rr
         IvtgOKZBMgwmh0+wFifXT3WLSMkv0ltCz+Egg=
Received: by 10.141.44.18 with SMTP id w18mr91381rvj.272.1249586865080; Thu, 
	06 Aug 2009 12:27:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125111>

When I typed 'git branch --contains efabdfb' on a machine today, I was
surprised to receive this error message: "error: malformed object name
efabdfb"

I would have expected instead to receive the message: "no such commit: efabdfb".

I went hunting through the source code and found the origination point
of the error:

/parse-options.c
 610 int parse_opt_with_commit(const struct option *opt, const char
*arg, int unset)
 611 {
 612 	unsigned char sha1[20];
 613 	struct commit *commit;
 614
 615 	if (!arg)
 616 		return -1;
 617 	if (get_sha1(arg, sha1))
 618 		return error("malformed object name %s", arg);
 619 	commit = lookup_commit_reference(sha1);
 620 	if (!commit)
 621 		return error("no such commit %s", arg);
 622 	commit_list_insert(commit, opt->value);
 623 	return 0;
 624 }

It appears the get_sha1 call is returning true, causing the 'malformed
object name' error to be returned.  However, it seems that ideally
since efabdfb is not malformed (it would be a valid ref if it
existed), the execution path should continue to line 619, receive no
commit, and fail on 621.

Am I off base here?
