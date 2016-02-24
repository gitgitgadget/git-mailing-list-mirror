From: Bill Okara <billokara@gmail.com>
Subject: git mv messed up file mapping if folders contain identical files
Date: Wed, 24 Feb 2016 16:38:11 -0700
Message-ID: <CADsr5c_Hk34KBN06dM9Hk5HPW9-Mt3eZLMgvyes8sSgxCA-k0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 00:38:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYj0e-0005yh-KT
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757504AbcBXXiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 18:38:14 -0500
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33682 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757352AbcBXXiM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 18:38:12 -0500
Received: by mail-ob0-f178.google.com with SMTP id jq7so33379475obb.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 15:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=8YXxz0/srxUUwYrKtUQHv3MgxAWFB+nw59fiOfy6wMg=;
        b=uwLY+MI5CbWmW5ZWeK3MlhzsIsC0YHrRunRwoanxXCUu/8HlNcJjBwik9V5LoO0k10
         sWOzbPKZ2HqDgKluZczEOczPgMWcIzaz7ED2+5vgeKTzNhQj3Q+9QAvIM5XgH54Xdf12
         H3xibwEw2S6g/hHkt0Sw59ppFLh0QhnEVnyViVuDs+Ch8gTst9+d2RZus0msRMU9RxUO
         YAcH6s8yjuW/3tRfLo/UKiFdfeNSvhcMrsk6SMFzkM/hWNv6milff5XOH7IPWryefvUl
         /zSZc/VQLCFtEK3tt+wBno4N4qhbx734cg8SXiJtmQYnIxqK1mvLAPM2GvrMQuyNmh8N
         hK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=8YXxz0/srxUUwYrKtUQHv3MgxAWFB+nw59fiOfy6wMg=;
        b=PtXVfYxYVMSsoMJlcqu1JiL9yI6aVfkkGc0T0IVhE55YCTMixu+2KL/EeFZfCITAOG
         VyAtFlTW+PcOi5nYvpnQAyZfn5t4QcBOVolSsNgM+yvRTy3ipAJjzQkOQvBDxCTXYk7k
         cR8/8SHmb5pj3VoCbgLIti9figebgU9lc+NzVNf8J20EzGHHM9Ui5JX1gdMznoJ3DO3T
         lTPYMtMSnou8pjkc6T2Q1OMTTAiUQQtXeqHY2DueE3sHwVfAP8sadV6e/mXLHucPPRxy
         5Fg/AeJXdLiKEulCbGA1Szwa/UoWuoO2p8+XQcbN+umM9LfhpOxwfarfLGcd6mkkmgYo
         pyNw==
X-Gm-Message-State: AG10YOSjRQXBFO2Zg5gy4atLaLgeArqvVE54KXA8pW+kGrIw7/kH3Td2TJknTazcxDPO/45AiWgYSpTktDu2JQ==
X-Received: by 10.60.128.163 with SMTP id np3mr9004371oeb.16.1456357091701;
 Wed, 24 Feb 2016 15:38:11 -0800 (PST)
Received: by 10.182.17.103 with HTTP; Wed, 24 Feb 2016 15:38:11 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287281>

Hi,

I noticed the following 'git mv' issue with:
git version 2.6.4


If there are identical files in different subfolders, 'git mv' the
root folder (and/or each file individually) will mess up the file path
mapping. that is, if having identical 'content.txt' file under
gitmvtest
    |--demo/content.txt
    |--dev/content.txt
    |--prod/content.txt

after doing the "git mv gitmvtest/resources
gitmvtest/src/main/resources", the 'git status' will show:

renamed:    gitmvtest/resources/demo/content.txt ->
gitmvtest/src/main/resources/demo/content.txt
renamed:    gitmvtest/resources/prod/content.txt ->
gitmvtest/src/main/resources/dev/content.txt            <== NOTE:
wrongly mapped the prod/content.txt to dev/content.txt
renamed:    gitmvtest/resources/dev/content.txt ->
gitmvtest/src/main/resources/prod/content.txt            <== NOTE:
wrongly mapped the dev/content.txt to prod/content.txt

I tried running 'git mv' on each file individually, got the same problem:
> git mv gitmvtest/resources/demo/content.txt gitmvtest/src/main/resources/demo/content.txt
> git mv gitmvtest/resources/dev/content.txt gitmvtest/src/main/resources/dev/content.txt
> git mv gitmvtest/resources/prod/content.txt gitmvtest/src/main/resources/prod/content.txt

> git status
renamed:    gitmvtest/resources/demo/content.txt ->
gitmvtest/src/main/resources/demo/content.txt
renamed:    gitmvtest/resources/prod/content.txt ->
gitmvtest/src/main/resources/dev/content.txt          <== WRONG
renamed:    gitmvtest/resources/dev/content.txt ->
gitmvtest/src/main/resources/prod/content.txt          <== WRONG


NOTE:
=======
if modified the content.txt in the 3 folders to contain different
data, then repeating the above 'git mv' will produce correct result,

renamed:    gitmvtest/resources/demo/content.txt ->
gitmvtest/src/main/resources/demo/content.txt       <== CORRECT
renamed:    gitmvtest/resources/dev/content.txt ->
gitmvtest/src/main/resources/dev/content.txt             <== CORRECT
renamed:    gitmvtest/resources/prod/content.txt ->
gitmvtest/src/main/resources/prod/content.txt          <== CORRECT



just want to see if this is a bug, user error (on my end), or??


Thanks,
Bill
