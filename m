From: "Dana How" <danahow@gmail.com>
Subject: [RFC] Packing large repositories
Date: Wed, 28 Mar 2007 00:05:08 -0700
Message-ID: <56b7f5510703280005o7998d65pcbcd4636b46d8d23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: danahow@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 09:05:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWSDz-0008Jp-EN
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 09:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964769AbXC1HFO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 03:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbXC1HFN
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 03:05:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:48658 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964769AbXC1HFK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 03:05:10 -0400
Received: by ug-out-1314.google.com with SMTP id 44so120075uga
        for <git@vger.kernel.org>; Wed, 28 Mar 2007 00:05:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oEQr1eVq78MH6G2cdv7DbwAvcfui8d+OEdCGWwzrP58qQ3DGJO+6q+RylgA+jXYLAvFJIjLbg/BJdcw3a0QkKnMQqXS9jp3OebmdviccSlNcvtOZFuB53VrQizhSRNNN2AafI+EV51KZ4BNUvuBWXCQVEoyqBnZH095104lUSv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kaaNhTepjI7kwXnN2fFHb/1+ZKw3XPhUeglr5CODAeSLxGhozusJP1k4Sikoft7mEGUVImWnz0jjJ9+Qi0qBnkIkVVLIFb9/mL2oGBjNS0C7e8V9t8WJdXk1tIOtreVp9PgRnKcKwMAPPsDK6WaIQoxpyKmd/gCzvHLT2bWsaHI=
Received: by 10.114.148.1 with SMTP id v1mr3538533wad.1175065508203;
        Wed, 28 Mar 2007 00:05:08 -0700 (PDT)
Received: by 10.115.55.10 with HTTP; Wed, 28 Mar 2007 00:05:08 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43355>

Hi,

I just started experimenting with using git on
a large engineering project which has used p4 so far.
Part of a checkout is about 55GB;
after an initial commit and packing I have a 20GB+ packfile.
Of course this is unusable, since object_entry's in an .idx
file have only 32 bits in their offset fields.  I conclude that
for such large projects,  git-repack/git-pack-objects would need
new options to control maximum packfile size.

[ I don't think this affects git-{fetch,receive,send}-pack
since apparently only the pack is transferred and it only uses
the variable-length size and delta base offset encodings
(of course the accumulation of the 7 bit chunks in a 32b
 variable would need to be corrected, but at least the data
format doesn't change).]

So I am toying with adding a --limit <size> flag to git-repack/git-pack-objects.
This cannot be used with --stdout.  If specified, e.g.
  git-repack --limit 2g
then each packfile created could be at most 2^31-1 bytes in size.
It's possible that multiple packfiles would be created in one shot.
Thus git-pack-objects could write multiple names to stdout
and git-repack would need to be updated accordingly.

Finally, I wonder if having tree/commit/tag objects mixed into
such large packfiles would be a performance hit.
(Or maybe this will only appear once I have real history,
 not just a large initial commit.  But I can say that I now have 48K
 data blobs and 9K others.)
To find out, I may experiment with adding a --type=<types> option
to git-repack/git-pack-objects.  Thus typing
  git-repack --limit 2g --type=tree+commit+tag,blob
would cause git-pack-objects to make 2 passes over its internal
object list. On the first, it would pack tree, commit, and tag objects.
On the second, it would pack blobs. Each pass would write at
least one independent packfile (or more with --limit).  This would also
allow different incremental repacking strategies/schedules for different types.

Comments?

Thanks!
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
