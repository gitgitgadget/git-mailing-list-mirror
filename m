From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH 0/8] fast-import: cache oe more often
Date: Tue, 20 Sep 2011 13:17:36 +0600
Message-ID: <CA+gfSn-nh4BhCPf6m8+EN0zo=BuhxRNLcLBx7ynRWPA=GxfDyg@mail.gmail.com>
References: <1316395657-6991-1-git-send-email-divanorama@gmail.com>
	<7vy5xj7tf5.fsf@alter.siamese.dyndns.org>
	<20110920042655.GH6343@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 09:17:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5uaM-0000Kz-Rq
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 09:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab1ITHRh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Sep 2011 03:17:37 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51372 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567Ab1ITHRh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2011 03:17:37 -0400
Received: by qyk30 with SMTP id 30so3559245qyk.19
        for <git@vger.kernel.org>; Tue, 20 Sep 2011 00:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Zj1xQm1MKQI6JIVFyrQf269s5Q8XUqpT8LsrHIkE3ec=;
        b=iU6rZGhvfefx2Y3VNs0R1loWfRXQX6AmcuFgcmKwqsauj4A5UNoEMP7CVIY6gg93gW
         7Kg9bZ2g3ht4NKDlYGBFv+tGLDCw8QNC6dMVXXO7mEiorNGHB1Chrhcrzh1ahwQeTurQ
         WDfwc/gTrgxGyaLMIacSrKa1iqRpMpf8552aw=
Received: by 10.229.70.130 with SMTP id d2mr336784qcj.130.1316503056638; Tue,
 20 Sep 2011 00:17:36 -0700 (PDT)
Received: by 10.229.224.17 with HTTP; Tue, 20 Sep 2011 00:17:36 -0700 (PDT)
In-Reply-To: <20110920042655.GH6343@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181735>

On Tue, Sep 20, 2011 at 10:26 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Junio C Hamano wrote:
>
>> I gave the series a cursory look, and the patches all looked like a =
good
>> and straight forward rewrites. =A0Provided if it is indeed a good id=
ea
>> overall to stuff more objects in-core, that is.
>
> Right, that's exactly the question I had. =A0When and why is it a goo=
d
> idea to stuff more objects in-core (or when might it be a bad idea,
> for that matter)?

The next step would be to replace sha1 with struct object_entry* in fas=
t-import.
So it'll be in struct tree_entry (twice, for each of versions[2]),
branch, tag, hash_list (used to store merge from lists), last_object.
Then some fields will be deleted as they can be accessed from
object_entry:
last_object->depth
last_object->offset
tree_content->delta_depth
branch,tag->pack_id

And it all even slightly decreased memory consumption (checked some
time ago, but think it's still true). Probably because of tree nodes
having NULL instead of null_sha1 and then ptr instead of sha1; and
maybe because for huge imports each object is from our pack so for a
sha1 there always is object_entry anyway.

In short, if there is nothing bad with this patchset, it'll be
absolutely natural one after switch to oe instead of sha1, but it's
put before to split the big series. And of course this part may have a
small speedup of it's own. If it's not too good to be accepted on it's
own, I'll just include it into future series depending on it.
