From: David Turner <dturner@twopensource.com>
Subject: verify_pack ignores return value of verify_fn
Date: Tue, 17 Nov 2015 19:31:55 -0500
Organization: Twitter
Message-ID: <1447806715.5082.11.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 18 01:33:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyqgT-00083l-Q4
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 01:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932763AbbKRAcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 19:32:53 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35654 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932453AbbKRAb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 19:31:58 -0500
Received: by qgec40 with SMTP id c40so17920958qge.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 16:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:organization:content-type
         :mime-version:content-transfer-encoding;
        bh=LYlTtoxjtM0Jk74jeGhUBwtEh2zI2nv6Cxk+273lA20=;
        b=mZBMdnOuipbNxin7//R4ngBHF738F50DXSLozPrdoWnvvgWEdt32aG8YGQE5AOmqEB
         2c+yTVUTQ6EX7ci9JdFyPbGhctJdnUA/tn2wVr0EXUlZx7nxtbgwumcWKR+I5hMS0VkH
         4bA3IG0mMbHoK94gGMzm1Peu5vwrjkCen0s2fjpET3WTPQ3UDow5247ys04Ya6dQjGyY
         hapZkoY4ETrKHMc0dECTmAeBB7/vVyG5wT1poVJvopG1h8FgA1jXj1eOtgnxeTVwUdSw
         cYgwDFCOnJ93+ADdzraObZEamWLEJxGOxHvtV+Dcm6KwxSVx3KDSZQvm4ZHanvX0GgUI
         O2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=LYlTtoxjtM0Jk74jeGhUBwtEh2zI2nv6Cxk+273lA20=;
        b=U43v8yBPoYHYnuUDmaY/fz0dpt7v1H9Cn9E0OAxoAJ4LVUAUBJYe0NcpgNtIgIY42f
         Rctug6Aa7VoArhxbctRbIGVK9HepZqDzWa/18b2VUyCeiiD9X9zSpFJSQDbhf4oUpGgM
         VmykQoXPSKmHmC3qwKalVxbNBEg0koP9cplDln51+me8DSvxqKbR0Avojcnk+hU4d5Sn
         u1QgMu9v8ssspKdTndeKQLsUJOyLnoILbOIeZKKwoAO8k+FWhO+2b7g8jyg9xN0VCCt4
         wwCMputw1RuvH6k9deWqHCXta5rzsWS2Lcny9BLvOowatzg/4qEG7UQHumq9JL4VY2U7
         Vrnw==
X-Gm-Message-State: ALoCoQnjexGEbvi/6JXrxVQdI4892GvuyOJbUIi4SXd9cHsJnOv5xAOjRy0X/87WlZFIGnqW2oja
X-Received: by 10.140.104.19 with SMTP id z19mr16553349qge.75.1447806717519;
        Tue, 17 Nov 2015 16:31:57 -0800 (PST)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id x79sm30927qka.37.2015.11.17.16.31.56
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2015 16:31:56 -0800 (PST)
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281434>

In pack-check.c, line 129, a caller-supplied verification function is
called.  The function returns an int, but that return value is ignored.

The only caller of verify_pack is in builtin/fsck.c, whose verify_fn
*does* return a meaningful error code (which is then ignored).  If it
were not ignored, fsck might return a different error code (in the
unlikely event that a weird object gets into a pack and is somehow not 
totally corrupt enough to fail an earlier check).

I think we should probably have verify_pack return a non-zero result if
any call to verify_fn returns a non-zero result.  Any objections to
this?
