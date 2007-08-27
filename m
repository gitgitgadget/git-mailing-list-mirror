From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Git and OpenDocument (OpenOffice.org) files
Date: Mon, 27 Aug 2007 11:52:22 +0200
Message-ID: <vpqk5rh5mp5.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 11:52:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPbGx-0004D9-8Z
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 11:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbXH0Jwg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 05:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbXH0Jwg
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 05:52:36 -0400
Received: from imag.imag.fr ([129.88.30.1]:63087 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753195AbXH0Jwf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 05:52:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7R9qMAp003915
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 27 Aug 2007 11:52:23 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IPbGg-0005C9-Op; Mon, 27 Aug 2007 11:52:22 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IPbGg-0005MF-Kb; Mon, 27 Aug 2007 11:52:22 +0200
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 27 Aug 2007 11:52:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56797>

Hi,

I found a way to use git comfortably with OpenDocument files (that is,
what OpenOffice.org and Koffice produce. Text, Presentations and
Spreadsheets).

Briefly, you have to install odf2txt ( http://stosberg.net/odt2txt/ )
and the script below, together with GIT_EXTERNAL_DIFF and/or diff
drivers in .gitattributes. That give you the text diff you're used to.

Everything is documented here:

  http://www-verimag.imag.fr/~moy/opendocument/

Remarks are welcome (I'll post some remarks about Git's custom diff
driver in a separate thread).


Script available from
http://www-verimag.imag.fr/~moy/opendocument/git-oodiff and reproduced
here :

#! /bin/sh

# Script acceptable as a value for GIT_EXTERNAL_DIFF.
# For example, you can see the changes in your working tree with
# 
# $ GIT_EXTERNAL_DIFF=git-oodiff diff

echo $0 "$@"

if odt2txt "$2"  > /tmp/oodiff.$$.1  && \
    odt2txt "$5" > /tmp/oodiff.$$.2 ; then
    if diff -L "a/$1" -L "b/$1" -u /tmp/oodiff.$$.{1,2}; then
        # no text change
        if diff -q "$2" "$5"; then
            : # no change at all
        else
            echo "OpenDocument files a/$1 and b/$1 files differ (same text content)"
        fi
    fi
else
    # conversion failed. Fall back to plain diff.
    diff -L "a/$1" -L "b/$1" -u "$2" "$5"
fi

rm -f /tmp/oodiff.$$.{1,2}
