From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 0/4] Support for running tests outside t/ + don't run a TODO test
Date: Wed, 18 Aug 2010 13:34:29 +0000
Message-ID: <1282138473-15613-1-git-send-email-avarab@gmail.com>
References: <7vpqxhaw92.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 15:34:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olin4-0005UR-Eg
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 15:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144Ab0HRNeo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 09:34:44 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:53317 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116Ab0HRNem (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 09:34:42 -0400
Received: by wwf26 with SMTP id 26so2556553wwf.1
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=sJfa1N/PiNzWr+LVpCwPbXffQtaadNirX7TjoTxbgfA=;
        b=vJxfKRKn6YQvGFLYeLM/KmUpMAtR7/BYcpw2KMg8wn/rWd6QT3L5+KIaUjkCTiHNLr
         nMOYZZROe3YN45Zn83MuSAn//xrua70/PBQr3mE6yZaIsyfjDVaHlO33SyGVa5tmgpKX
         NsXzfsv5FGc3GDVcT7aSi9a5emo5kSoVjeXJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VFdarLQzLapNK3Ai8mrziDbjN9cvpSvjfD8RxMxnCGSOY+52J+FoJSd8hbEK1xNK7R
         rbhLoVyqFyDv7lVGii5zTkLoD3rlye1d/0CacJdGkRVTFFGtl3RhtQYNWuhrzPsmZJmM
         7SIHKDh4G7Stz0rwqCRGr69nsAGbG97dcKXWo=
Received: by 10.227.138.71 with SMTP id z7mr4018395wbt.173.1282138481010;
        Wed, 18 Aug 2010 06:34:41 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id r10sm230012wbe.18.2010.08.18.06.34.40
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 06:34:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.414.g9bf49
In-Reply-To: <7vpqxhaw92.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153842>

On Tue, Aug 17, 2010 at 19:12, Junio C Hamano <gitster@pobox.com> wrote=
:
> Sverre Rabbelier <srabbelier@gmail.com> writes:
>
>> E.g., something like:
>>
>> test_in_new_harness 0 1 0 0 '
>>     test_expect_failure 'pretend we have fixed a known breakage' '
>>            :
>>      '
>> '
>
> Now the question becomes who tests "test_in_new_harness" ;-)
>
> I'd rather prefer not to touch this one.  Isn't whatever the outer wr=
apper
> used flexible enough to be taught about this kind of thing and filter=
 it?

The problem is that you have to modify *all* the outer wrappers. Since
the test suite can be run with any TAP consumer that isn't viable, and
at the very least having to do:

    prove --source=3DSome::Custom::Git Thing ...

Is tedious, and requires us to maintain the Some::Custom::Git thingy.

Anyway, here's a better patch. It allows us to run a pasing TODO test,
check if it works, and if so not mark *that* test as passing TODO, but
simply as passing.

As a side benefit it makes the test lib more awesome.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
  test-lib: Use $TEST_DIRECTORY or $GIT_BUILD_DIR instead of $(pwd) and
    ../
  test-lib: Use "$GIT_BUILD_DIR" instead of "$TEST_DIRECTORY"/../
  test-lib: Allow overriding of TEST_DIRECTORY
  t/t0000-basic.sh: Run the passing TODO test inside its own test-lib

 t/t0000-basic.sh |   31 +++++++++++++++++++++++++++++++
 t/test-lib.sh    |   39 +++++++++++++++++++++++----------------
 2 files changed, 54 insertions(+), 16 deletions(-)

--=20
1.7.2.1.414.g9bf49
