From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Bug when git rev-list options "--first-parent" and "--ancestry-path"
 are used together?
Date: Thu, 23 May 2013 12:07:04 +0200
Message-ID: <519DEA48.10108@alum.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010503010901040606030205"
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 12:07:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfSQU-0006LQ-GF
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 12:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758033Ab3EWKHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 06:07:08 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:57465 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757887Ab3EWKHH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 May 2013 06:07:07 -0400
X-AuditID: 1207440f-b7f0e6d000000957-a1-519dea4a216e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 78.26.02391.A4AED915; Thu, 23 May 2013 06:07:06 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4NA74FB013719
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 May 2013 06:07:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsUixO6iqOv1am6gwZ7THBZdV7qZLBp6rzA7
	MHlcvKTs8XmTXABTFLdNUmJJWXBmep6+XQJ3xspfaxgLVgtVTJjyibWBcT9vFyMnh4SAicSv
	puvsELaYxIV769m6GLk4hAQuM0r8vNPMDuFcY5LYufMfM0gVr4CmxOVvb1hBbBYBVYl77c1g
	cTYBXYlFPc1MILaoQJjE+2VTWSHqBSVOznzCAmKLCFhL/D56CmybsECSxNJX58FsZoEAibbN
	C5gnMPLMQtIyC0kKwtaReNf3AMqWl9j+dg6UrSux58hpFkxxI4nTuzpYFzCyr2KUS8wpzdXN
	TczMKU5N1i1OTszLSy3SNdHLzSzRS00p3cQICVT+HYxd62UOMQpwMCrx8B64MSdQiDWxrLgy
	9xCjJAeTkiivxdO5gUJ8SfkplRmJxRnxRaU5qcWHGFWAlj3asPoCoxRLXn5eqpII7+YeoDre
	lMTKqtSifJgyaQ4WJXFe9SXqfkIC6YklqdmpqQWpRTBZGQ4OJQne5pdAjYJFqempFWmZOSUI
	aSYOzkOMEhxcUiLFqXkpqUWJpSUZ8aAYji8GRjFIigdo78QXIHuLCxJzgaIQracYdTlm/Jj8
	jlEI7Dgpcd5ekB0CIEUZpXlwK2Dp6hWjOND3wrytIFU8wFQHN+kV0BImoCVLT80BWVKSiJCS
	amDUWL9tQQiT/XxJDWNb9UgG5fw3qtU3l2+fnPzG+8Zj2fWdd4yf7dobanBbeEdEynsb5lcc
	AZnSltOXG919x8F2VGL6JrdbB2SV5r1wmbz/T0vJ5W+v5lrn3Y9iCP/vbJFw7VLe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225230>

This is a multi-part message in MIME format.
--------------010503010901040606030205
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

It seems to me that

     git rev-list --first-parent --ancestry-path A..B

is well-defined and should list the commits in the intersection between

     git rev-list --first-parent                 A..B

and

     git rev-list                --ancestry-path A..B

But in many cases the first command doesn't provide any output even
though there are commits common to the output of the last two commands.

For example, take as an example the DAG from test t6019:

#          D---E-------F
#         /     \       \
#    B---C---G---H---I---J
#   /                     \
#  A-------K---------------L--M

(The merges are always downwards; e.g., the first parent of commit L is
K.)  The command

    git rev-list --first-parent --ancestry-path D..J

doesn't generate any output, whereas I would expect it to output "H I
J".  Similarly,

    git rev-list --first-parent --ancestry-path D..M

doesn't generate any output, whereas I would expect it to output "L M".

For fun, the attached script computes the output for all commit pairs in
this DAG and outputs the discrepancies that it finds.  (It should be run
in directory "t/trash directory.t6019-rev-list-ancestry-path" after
t6019 was run with "-d".)

Is this a bug or are my expectations wrong?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

--------------010503010901040606030205
Content-Type: application/x-sh;
 name="x.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="x.sh"

#! /bin/bash

commits="A B C D E F G H I J K L M"

GIT=../../bin-wrappers/git

intersect() {
    comm -1 -2 \
        <($GIT rev-list --first-parent $1..$2 | sort) \
        <($GIT rev-list --ancestry-path $1..$2 | sort)
}

delta() {
    opt=$1
    shift
    diff $opt \
        <($GIT rev-list --first-parent --ancestry-path $1..$2 | sort) \
        <(intersect $1 $2)
}

for a in $commits
do
    for b in $commits
    do
	if ! delta -q $a $b >/dev/null
	then
            echo "$a..$b differ!"
            delta -y $a $b
        fi
    done
done


--------------010503010901040606030205--
