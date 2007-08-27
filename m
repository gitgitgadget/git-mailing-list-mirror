From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Git and OpenDocument (OpenOffice.org) files
Date: Mon, 27 Aug 2007 14:35:14 +0200
Message-ID: <vpqtzql17gd.fsf@bauges.imag.fr>
References: <vpqk5rh5mp5.fsf@bauges.imag.fr>
	<7vps19jnm1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 14:35:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPdow-0002TY-PE
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 14:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbXH0Mfv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 08:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbXH0Mfv
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 08:35:51 -0400
Received: from imag.imag.fr ([129.88.30.1]:61164 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751804AbXH0Mfu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 08:35:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7RCZEtb005012
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 27 Aug 2007 14:35:14 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IPdoI-0001KU-9p; Mon, 27 Aug 2007 14:35:14 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IPdoI-000604-7O; Mon, 27 Aug 2007 14:35:14 +0200
In-Reply-To: <7vps19jnm1.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 27 Aug 2007 03\:08\:54 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 27 Aug 2007 14:35:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56825>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Remarks are welcome (I'll post some remarks about Git's custom diff
>> driver in a separate thread).
>
> Good.
>
> I think creation/deletion will get /dev/null as the temporary
> file name, so as long as odt2txt knows how to deal with
> /dev/null you would not have to worry much about them.

But odt2txt doesn't know how to deal with /dev/null. New version of
git-oodiff that manages it correctly online and below.

> You might want to be careful about unmerged paths, though.  They
> will not get anything other than $1 (name).

I don't know how to manage this correctly, so I just display a message
"Unmerged path $1" and die.

> You would probably not care about the mode changes for oo
> documents, but they are available as $4 and $6 respectively, if
> you care.

I don't care, but the new version still manages them ;-).

All this convince me that the ability to provide a plaintext converter
(see the other thread I started) would make it much simpler to write
such kind of things. The mode change, for example, could be managed
automatically by git, I wouldn't need to write my own 'echo "new
mode ..."'.

Thanks for the advices.

-- 
Matthieu

http://www-verimag.imag.fr/~moy/opendocument/git-oodiff

#! /bin/sh

# Script acceptable as a value for GIT_EXTERNAL_DIFF.
# For example, you can see the changes in your working tree with
# 
# $ GIT_EXTERNAL_DIFF=git-oodiff diff

convert_to_txt ()
{
    if [ x"$1" = x"/dev/null" ]; then
        printf "" > /tmp/oodiff.$$."$2"
        eval "label$2=/dev/null/"
    else
        odt2txt "$1" > /tmp/oodiff.$$."$2" 2>/dev/null
    fi
}

echo $(basename $0) "$2" "$5"

if [ "$#" = "1" ]; then
    echo "Unmerged path $1"
    exit 0
fi

if   [ x"$4" = x"." ]; then
    echo "new file mode $7"
elif [ x"$7" = x"." ]; then
    echo "deleted file mode $4"
elif [ x"$4" != x"$7" ]; then
    echo "old mode $4"
    echo "new mode $7"
fi

label1="a/$1"
label2="a/$1"

if convert_to_txt "$2" "1" &&
    convert_to_txt "$5" "2" ; then
    if diff -L "$label1" -L "$label2" -u /tmp/oodiff.$$.{1,2}; then
        # no text change
        if diff -q "$2" "$5"; then
            : # no change at all
        else
            echo "OpenDocument files a/$1 and b/$1 files differ (same text content)"
        fi
    fi
else
    # conversion failed. Fall back to plain diff.
    diff -L "$label1" -L "$label2" -u "$2" "$5"
fi

rm -f /tmp/oodiff.$$.{1,2}
