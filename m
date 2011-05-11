From: Robert <yayooo@gmail.com>
Subject: http.receivepack==false && authenticated => Service not enabled
Date: Wed, 11 May 2011 10:21:20 +0000
Message-ID: <BANLkTikZdvW1ptVNBiJpCX7jdrqxq=CaDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 17:43:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKBZb-0001hF-KT
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 17:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308Ab1EKPn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 11:43:26 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51640 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab1EKPnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 11:43:25 -0400
Received: by gxk21 with SMTP id 21so203227gxk.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 08:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=tH1Huipe7TwlbqlQflJ9GtobmT2EKKl8DjDwmMcaHjE=;
        b=Y2jG5+A5b6brfLb8N5hYUKKbL/WMVfDbioCvSwJ/TeyRAB8RCToZfalQ2SrNOyzV5B
         nUOY9CxpPVJE7RGoPZg6iBPyoAPg8lpY9l4Iq0tmqaInSc/6vErIxg9rBfVqQQk3zkAE
         39fBA0CpRgwWiXuJx711qMYmkQWsqBDCUBK54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=nsVwVZhg4dImhYAd6Zm67VAPvFRcCv8eEH3peVRjbivStDaPBj+J26JUd9M/eSQHs5
         jOPt9FPYL/+O7ReThUl8a1dk+sY1FXZtguipwpmKL5Z565L5rQjnGQcMlEgpYPhISTjc
         q6VbX0vd0U7x899pNh8umq0MwiTkr+uH95x80=
Received: by 10.151.88.42 with SMTP id q42mr4136191ybl.402.1305109280822; Wed,
 11 May 2011 03:21:20 -0700 (PDT)
Received: by 10.150.220.4 with HTTP; Wed, 11 May 2011 03:21:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173392>

Even a authenticated  user can not push when http.receivepack set to false.
when
git config http.receivepack false
svc->enabled was set to 0 not -1
so we should initialize with 0 not -1

--- http-backend.c      Thu May  5 01:16:14 2011
+++ http-backend.c   Wed May 11 09:57:52 2011
@@ -23,7 +23,7 @@

 static struct rpc_service rpc_service[] = {
        { "upload-pack", "uploadpack", 1 },
-       { "receive-pack", "receivepack", -1 },
+       { "receive-pack", "receivepack", 0 },
 };

 static struct string_list *get_parameters(void)
@@ -260,8 +260,8 @@
        if (!svc)
                forbidden("Unsupported service: '%s'", name);

-       if (svc->enabled < 0) {
                const char *user = getenv("REMOTE_USER");
+       if (!svc->enabled) {
                svc->enabled = (user && *user) ? 1 : 0;
        }
        if (!svc->enabled)
