From: Andreas Leha <andreas.leha@med.uni-goettingen.de>
Subject: make git ignore the timestamp embedded in PDFs
Date: Tue, 14 May 2013 15:17:59 +0200
Message-ID: <87y5bhn1iw.fsf@med.uni-goettingen.de>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 16:05:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcFqs-00046e-SS
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 16:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757500Ab3ENOFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 10:05:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:35160 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757490Ab3ENOFG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 10:05:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UcFqh-0003yh-K3
	for git@vger.kernel.org; Tue, 14 May 2013 16:05:03 +0200
Received: from genepi110.genepi.med.uni-goettingen.de ([134.76.140.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 May 2013 16:05:03 +0200
Received: from andreas.leha by genepi110.genepi.med.uni-goettingen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 May 2013 16:05:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: genepi110.genepi.med.uni-goettingen.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:f9KQwCGCIzG+k0+oYGT70i38wVo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224298>

Hi all,

how can I make git ignore the time stamp(s) in a PDF.  Two PDFs that
differ only in these time stamps should be considered identical.

Here is an example:
,----
| > pdfinfo some.pdf
| Title:          R Graphics Output
| Creator:        R
| Producer:       R 2.15.1
| CreationDate:   Thu Jan 24 13:43:31 2013 <==  these entries
| ModDate:        Thu Jan 24 13:43:31 2013 <==  should be ignored
| Tagged:         no
| Pages:          1
| Encrypted:      no
| Page size:      504 x 504 pts
| File size:      54138 bytes
| Optimized:      no
| PDF version:    1.4
`----


What I tried is a filter:
,----[ ~/.gitconfig ]
| [filter "pdfresetdate"]
|         clean = pdfresetdate
`----

With this filter script:
,----[ pdfresetdate ]
| #!/bin/bash
|
| FILEASARG=true
| if [ "$#" == 0 ]; then
|     FILEASARG=false
| fi
|
| if $FILEASARG ; then
|     FILENAME="$1"
| else
|     FILENAME=`mktemp`
|     cat /dev/stdin > "${FILENAME}"
| fi
|
| TMPFILE=`mktemp`
| TMPFILE2=`mktemp`
|
| ## dump the pdf metadata to a file and replace the dates
| pdftk "$FILENAME" dump_data | sed -e '{N;s/Date\nInfoValue: D:.*/Date\nInfoValue: D:19790101072619/}' > "$TMPFILE"
|
| ## update the pdf metadata
| pdftk "$FILENAME" update_info "$TMPFILE" output "$TMPFILE2"
|
| ## overwrite the original pdf
| mv -f "$TMPFILE2" "$FILENAME"
|
| ## clean up
| rm -f "$TMPFILE"
| rm -f "$TMPFILE2"
| if [ -n $FILEASARG ] ; then
|     cat "$FILENAME"
| fi
`----


This 'works' as far as the committed pdf indeed has the date reset to my
default value.

However, when I re-checkout the files, they are marked modified by git.

So, my question is:  How can I make git *completely* ignore the embedded
date in the PDF?

Many thanks in advance for any help!

Regards,
Andreas


PS:
I had posted this question (without much success) here:
http://stackoverflow.com/questions/16058187/make-git-ignore-the-date-in-pdf-files
and with no answer on the git-users mailing list:
https://groups.google.com/forum/#!topic/git-users/KqtecNa3cOc
