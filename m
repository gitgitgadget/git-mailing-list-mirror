From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-svn checksum mismatch importing large file
Date: Wed, 17 Sep 2008 13:39:35 -0400
Message-ID: <32541b130809171039q22d3776aw45e6ec347c315248@mail.gmail.com>
References: <48D0B77E.7010308@obry.net> <20080917082506.GA8849@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Pascal Obry" <pascal@obry.net>, "git list" <git@vger.kernel.org>,
	"Eric Wong" <normalperson@yhbt.net>
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 17 19:40:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg11B-0008JM-OF
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 19:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbYIQRji convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Sep 2008 13:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753183AbYIQRji
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 13:39:38 -0400
Received: from rn-out-0910.google.com ([64.233.170.187]:20765 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177AbYIQRjh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Sep 2008 13:39:37 -0400
Received: by rn-out-0910.google.com with SMTP id k40so1952262rnd.17
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 10:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pvRBgAIcSqz0PWVYSNZOPKZjip0nIFU99a5eid+o4EU=;
        b=QT5wbO2nPbn1rXy+SuXMyubG3BjfxZUkUez8hsW2GD2j9AjTF7sb2RIo48KHecAPF1
         DdHpHC5W9eI4wpehkn3IH5O3YQsMdFgH6VKXL21Ybzl0a4qSmmc0yVnZVcoTAg81Fnl5
         X9qie7PLkc9yno87pyNohO+E8lQJNbJd8lmDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=b6fiXxo1pxNFCLNu+oGq4PIFCw1CEt2pta+YejFRPvjRWTiOKpBtb0iBF85uxcmT6R
         jlk/9PStLL9vT0u7pyDDXC8tKdT0nU4Umy9I03D4E2Ml7cITEZT06i0edtvSVuYCSdo2
         O770qFlOi9gpgd7K5GGdoj5RSmyoS+hYaPqWk=
Received: by 10.151.145.11 with SMTP id x11mr3963831ybn.162.1221673175857;
        Wed, 17 Sep 2008 10:39:35 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Wed, 17 Sep 2008 10:39:35 -0700 (PDT)
In-Reply-To: <20080917082506.GA8849@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96131>

On Wed, Sep 17, 2008 at 4:25 AM, Bj=F6rn Steinbrink <B.Steinbrink@gmx.d=
e> wrote:
> On 2008.09.17 09:53:34 +0200, Pascal Obry wrote:
>> I get this error:
>>
>> Checksum mismatch: trunk/data
>> expected: 7c59e4dd67b5a9fde6c61cada070537b
>>     got: 3fcd9d077a5aa51a784a452c9d78d6e0
>>
>> To reproduce launch run.sh in attached archive.
>>
>> I have had this problem since some time now and I finally got some t=
ime
>> to create a reproducer. I have reproduced this problem with yesterda=
y
>> master Git version.
>
> Your /tmp is probably to small to hold the temporary file that git-sv=
n
> creates. At least it doesn't fail for me unless I fill my /tmp first.
>
> This should be fixed since 29c70e0b3e3183f86f93500882177d0c74069988, =
at
> least it got me a useful error message when I tested it back then.
> Avery, any ideas?

It is possible that before my patch, you wouldn't have gotten that
error message - instead you would have gotten a corrupt repository,
which might have been caught later with an even more obscure-sounding
error.  It does appear that there's a write() call somewhere in
git-svn that still isn't protected by an "or die", however, because
we're getting an invalid checksum without getting a write error first.

In any case, if the problem is a giant file that won't fit in /tmp,
the best we could do in git-svn is produce a better error message.
/tmp is still the "right" place to put temp files.  I agree with the
suggestion to try pointing the TMPDIR environment variable somewhere
else... or else make your /tmp bigger.

Have fun,

Avery
