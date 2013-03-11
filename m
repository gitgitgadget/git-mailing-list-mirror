From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/6] Exclude optimizations
Date: Mon, 11 Mar 2013 22:11:21 +0700
Message-ID: <CACsJy8D=P0Fyg5MoVry8JnsxsKsrQZXqWsvi_Yrb-G_VfCtDRg@mail.gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com> <1362896070-17456-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 11 16:12:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF4Ol-0005Ni-4x
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 16:12:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821Ab3CKPL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 11:11:56 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:54944 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab3CKPLz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 11:11:55 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so4661941oag.29
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 08:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=u7j/sMV6df2NzlI8DF/n54K3FxBp2Wi6FS8JKxPo6D0=;
        b=U7KRULDgneFWBQhL5Oe9fjz8DpQEmOJDjS1sgK8PhbInqc54GvKVrNY3XRVKv5N4bE
         pnFckilsAFoez8/foGbsPU8Y2azp687UZt3eHJcuq4HSehQ1+bALOcjzpiyv8BjSW5tr
         v9t8GG1nifprlt4VwtUW+B88TVdYXafgJsWm0Jboza8wRzSpAcNnedBCTK12RbhyltOu
         3QkyAX5UNlMR2Dno+qjyZc1nZlekiX6gDhCP9dFLovZxxq7B3YLf8vB2pdVJmD4ksEHq
         G1zvcDQYOWIYwHHg7IAufFbFJ8jDulXzVftu46BhMUku9a6pvvpWgIhM9IbTHl969KoG
         djxg==
X-Received: by 10.182.235.49 with SMTP id uj17mr8877724obc.18.1363014713094;
 Mon, 11 Mar 2013 08:11:53 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Mon, 11 Mar 2013 08:11:21 -0700 (PDT)
In-Reply-To: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217878>

The hunt continues.. (and thanks everyone for suggestions). Now
is_excluded() (and exclude machinery) is no longer the hot spot in
read_directory. index_name_exists is the new star:

function                  time (in seconds)
treat_leading_path:       0.000
read_directory:           0.289
+treat_one_path:          0.147
++is_excluded:            0.013
+++prep_exclude:          0.006
+++matching:              0.004
++dir_exists_in_index:    0.008
++index_name_exists:      0.117 <--
+++lazy_init_name_hash:   0.060
+simplify_away:           0.004
+dir_add_name:            0.000

real    0m0.372s
user    0m0.256s
sys     0m0.114s  <-- can't kill this one (*) until we get inotify support

I think if we save the hash in index, we could nearly cut
lazy_init_name_hash out (or not, perf reported insert_hash near the
top, not hash_name). Any ideas to further reduce iname_name_exists
cost are welcome. 0.117s on 2.50GHz turns to 0.549s on my Atom 1.6GHz,
so I think it's worth doing something about it.

(*) I tried breadth-first search, checking for .gitignore existence
before opening, chdir() to shorten pathnames. Nothing worked.
-- 
Duy
