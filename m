From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Getting a commit sha1 from fast-import in a remote-helper
Date: Mon, 17 Nov 2014 19:27:41 -0800
Message-ID: <20141118032740.GJ4336@google.com>
References: <20141118003426.GA6528@glandium.org>
 <20141118022137.GA8418@glandium.org>
 <20141118023520.GB14034@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Nov 18 04:27:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqZSC-0001jO-W8
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 04:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347AbaKRD1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 22:27:40 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38858 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbaKRD1k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 22:27:40 -0500
Received: by mail-ig0-f171.google.com with SMTP id uq10so307555igb.16
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 19:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NfzzxnE/5q+arXWN4W2csj7o6dyIto6h6tMGyJxxz/8=;
        b=jlqGr6jSs0rd2pc0R8i8fE0T2h7eHTyMdG3p2ar8bTj8I6MNppXbCamrgFGMHq+Kap
         oSzKuVjdsC3egUvK0IsEHpywEWSvboidnqOjw4VhbAwirL8c9yayfDBhgNxDz9Dvyiim
         NffVgXJnCFH5lOU/tHbsinlinMqnQRXews55kXVcmALk5BiwUfAVw7NcXaKBsfQksAni
         Vs61PevNxkZ5vyvQRN4np2aTHuWW26/xeVSNVGCA8eKl4gDGY+AkCr1AtCePHm8zwv/i
         N55zHOy1JOlcLbmz279oHxPCzlqud0vbr1fvPpi8LhIISzlAL3jncM24fLvCYSVbbmxz
         eS1A==
X-Received: by 10.107.155.209 with SMTP id d200mr34782743ioe.12.1416281259394;
        Mon, 17 Nov 2014 19:27:39 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1d6d:1067:602d:d9c7])
        by mx.google.com with ESMTPSA id 5sm6991610igl.17.2014.11.17.19.27.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 19:27:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141118023520.GB14034@glandium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey wrote:

> And while I'm here, it's sad that one needs to emit a dummy cat-blob or
> ls command to wait for a checkpoint to be finished

That's a good point.  (Though relying on checkpoints to read back
information is an ugly trick, so if we can get other commands to
provide the information you need then that would be better.)

The old-fashioned way is to do "progress checkpoint done".  Alas, that
writes to the progress fd, which doesn't go to the remote helper's
stdin.  How about something like this?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/Documentation/git-fast-import.txt w/Documentation/git-fast-import.txt
index 377eeaa..c0dedac 100644
--- i/Documentation/git-fast-import.txt
+++ w/Documentation/git-fast-import.txt
@@ -1055,6 +1055,12 @@ ls::
 	rather than wasting time on the early part of an import
 	before the unsupported command is detected.
 
+notify-on-checkpoint::
+	Cause the backend to write `checkpoint complete` to the file
+	descriptor set with `--cat-blob-fd`, or to `stdout` if
+	`--cat-blob-fd` was unspecified, when finishing a checkpoint
+	requested via a `checkpoint` command or SIGUSR1.
+
 notes::
 	Require that the backend support the 'notemodify' (N)
 	subcommand to the 'commit' command.
diff --git i/fast-import.c w/fast-import.c
index d0bd285..ccf4768 100644
--- i/fast-import.c
+++ w/fast-import.c
@@ -329,6 +329,7 @@ static const char *import_marks_file;
 static int import_marks_file_from_stream;
 static int import_marks_file_ignore_missing;
 static int relative_marks_paths;
+static int notify_on_checkpoint;
 
 /* Our last blob */
 static struct last_object last_blob = { STRBUF_INIT, 0, 0, 0 };
@@ -3094,6 +3095,9 @@ static void checkpoint(void)
 		dump_tags();
 		dump_marks();
 	}
+	if (notify_on_checkpoint)
+		cat_blob_write("checkpoint complete\n",
+			       strlen("checkpoint complete\n"));
 }
 
 static void parse_checkpoint(void)
@@ -3244,6 +3248,8 @@ static int parse_one_feature(const char *feature, int from_stream)
 		option_export_marks(arg);
 	} else if (!strcmp(feature, "cat-blob")) {
 		; /* Don't die - this feature is supported */
+	} else if (!strcmp(feature, "notify-on-checkpoint")) {
+		notify_on_checkpoint = 1;
 	} else if (!strcmp(feature, "relative-marks")) {
 		relative_marks_paths = 1;
 	} else if (!strcmp(feature, "no-relative-marks")) {
