From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH (GITK) v3 0/4] Enhance encoding support.
Date: Wed, 15 Oct 2008 17:09:12 +0400
Message-ID: <bb6f213e0810150609y3e74935bq7cf35432fa219f55@mail.gmail.com>
References: <1223885554-27718-1-git-send-email-angavrilov@gmail.com>
	 <18677.58426.326371.788610@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Johannes Sixt" <johannes.sixt@telecom.at>
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 15:10:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq68x-0005T4-HM
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 15:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbYJONJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 09:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752828AbYJONJP
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 09:09:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:11623 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbYJONJO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 09:09:14 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1216039nfc.21
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 06:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8ZQUlcYhVWXsXOrkb8UsCtuIM/Ty5hO7jhYHZHzrFQk=;
        b=iFfyzl7YHsg+UGt/F0Kksb7uHUCCClynw1SD0EWtMaqNAqD7J8No4Azp3RKln9DA9u
         qa3oCIiFLmhVN9vq3NNLOHxtzJF3BaZHnk5aiMKnaPVHp4WVCVTSxzZ6nB+Uyq5qdDxg
         h2c8+NQ40ZBW1qTjsqj2OVjUDyeAeqf3PmmXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Lrs7Ur1RU+Pv4wsx7fqKVS+BtBes/YHFNIxsng/lBzMxixF7mTGcrkfE8ecuuC12Qr
         4Ho0Fy5DeUfNSIMKc9WVksNbbIzn1GmZk4i37tgoxqmXVLOKGd2zFm4Sr1K4vJ2B5SYi
         5xf29hSTkZP7K9d9UaTbzRcRVEKK6lRZ5akgA=
Received: by 10.103.251.2 with SMTP id d2mr532376mus.88.1224076152450;
        Wed, 15 Oct 2008 06:09:12 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Wed, 15 Oct 2008 06:09:12 -0700 (PDT)
In-Reply-To: <18677.58426.326371.788610@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98272>

On Wed, Oct 15, 2008 at 4:38 PM, Paul Mackerras <paulus@samba.org> wrote:
> Alexander Gavrilov writes:
>
>> Since git apparently cannot work with filenames in non-locale
>> encodings anyway, I did not try to do anything about it apart
>> from fixing some obvious bugs.
>
> What we did before was read filenames and convert them from the system
> encoding (done implicitly by gets) before unquoting filenames that
> were quoted.  What we do now with your patch 1/2 is that we read the
> filenames in binary and unquote any quoted filenames before converting
> from the system encoding.  So I don't think your patch would have made
> as much difference as it might appear.  If there is a reason for
> unquoting before converting from the system encoding rather than
> after, it seems pretty subtle to me and wasn't explained in the patch
> description.  An explanation, preferably with examples, would be
> useful.

The reason is that non-ASCII characters may be quoted too, so the
string that we read looks like
"\204\206\204y\204s\204\200\204r\204y\204~\204p.txt". There is no
point decoding it before unquoting.

> Also, you didn't say whether you found the "obvious bugs" by
> inspection or by encountering their effects in actual running (and if
> so, what those effects were).  That information is also good to have
> in the patch description.

I actually created a test repository with non-ASCII filenames. If I
remember it correctly, the bugs manifested as strings in the tree view
appearing as if they were decoded using ISO-8859-1 (the result of
decoding before unquoting), or unstaged files being listed quoted as
above.


Now the remaining encoding issues are:

1) Commit messages that are loaded through readcommit are decoded
using the system encoding. It is rare, but it happens. This is a bug.

proc readcommit {id} {
    if {[catch {set contents [exec git cat-file commit $id]}]} return
    parsecommit $id $contents 0
}

2) Gitk cannot process commits stored in multiple different encodings:
they all are decoded using the current value of i18n.commitencoding.
This seems to be low priority, because most GUI users are better off
using utf-8 for their commits anyway.

Alexander
