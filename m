From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] Perform cheaper connectivity check when pack is used
 as medium
Date: Sat, 3 Mar 2012 10:05:27 +0700
Message-ID: <CACsJy8B7u-rvnFZKi4t2CoB=J3Ra8pWxK4439NTdnHQDhm2ibQ@mail.gmail.com>
References: <7vmx849ma8.fsf@alter.siamese.dyndns.org> <1330435109-4437-1-git-send-email-pclouds@gmail.com>
 <7vwr73h6td.fsf@alter.siamese.dyndns.org> <CACsJy8D7JB9bzOvammGAx1rW04DEUCVzvfp-_Q1KtE9G00rZVQ@mail.gmail.com>
 <7v1upagb8z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 04:06:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3fIk-0007Ii-M5
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 04:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137Ab2CCDGY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Mar 2012 22:06:24 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:39098 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529Ab2CCDF6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2012 22:05:58 -0500
Received: by wejx9 with SMTP id x9so1398033wej.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 19:05:57 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.104.65 as permitted sender) client-ip=10.180.104.65;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.104.65 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.104.65])
        by 10.180.104.65 with SMTP id gc1mr1438382wib.13.1330743957475 (num_hops = 1);
        Fri, 02 Mar 2012 19:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=VIuTz3zmUfpN+FOhadFFNrCgGCraxsMpBbyzMFoXkFY=;
        b=Uzpk4zV9F8g2ys9W2lbp1VICIThDr9LzZSE7vo7TV23U9nHFPBj6PyYh4LOnGI3LTa
         cmgrCQADpyKKIf+e51fqKtp/eR6Ljnt8aY1gD6EhAn/6VZ1jkkXI5TOz1kQyGY4dfSev
         cTnCEOk72fBlEhB8XjE7jjLpgVmLzM17V4TJO9DzwF4xM0pQ488hEwu6Q2PAkXQA4gEK
         nT6tF9MdMAHdriO39oL0O/pqWM1qKp7uzQPK446ilmMXT69iebZTkXGLfMw6xiZpPJyo
         lyfAoGnu3phs7P1zVFClk3SS3mbm9aXTs021kAHtaKon7oO7EBNWvSHhHK5TFqZSEmuo
         BtNg==
Received: by 10.180.104.65 with SMTP id gc1mr1121438wib.13.1330743957408; Fri,
 02 Mar 2012 19:05:57 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Fri, 2 Mar 2012 19:05:27 -0800 (PST)
In-Reply-To: <7v1upagb8z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192093>

On Sat, Mar 3, 2012 at 12:31 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Not everything is valid, then. Objects from new packs are, existing
>> ones may be guilty. If there is a way to mark new packs trusted, the=
n
>> we only need to validate the other objects, which should be the
>> minority or even empty unless an attack is mounted.
>
> Yes, but how? =C2=A0Running "fsck" on all of pre-existing objects eve=
ry time
> you fetch (or accept push) is not an answer.
>
> If your fetch did not explode the incoming pack into pieces, a possib=
ility
> is to still use the --verify-object codepath, but pass the identity o=
f the
> pack (e.g. struct packed_git) down the callchain so that you can avoi=
d
> rehashing the objects that came from that single pack, but that would=
 not
> help the case where you ended up calling unpack-objects.

It won't help the unpack-objects case. But unpack-objects is only used
when the pack has less than a certain number of objects, doing heavy
check in that case should not take too long. Yes, I was thinking I
would pass pack identity down the verify-pack callchain for index-pack
case.

> I also suspect that more than trivial amount of computation is needed=
 to
> determine if a given object exists only in a single pack, so the end
> result may not be that much cheaper than the current --verify-object =
code.

Objects can exist in multiple packs right now if they are base
objects. I'm not sure why you need to check for object existence in a
single pack. index-pack tries to make sure duplicate objects with the
same sha-1 must be identical, content-wise. Though it does not do that
hard enough (i.e. only check with one in-repo instance of the object,
instead of all of them).
--=20
Duy
