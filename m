From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] send-pack: show progress when isatty(2)
Date: Tue, 1 May 2012 04:41:42 -0400
Message-ID: <20120501084139.GA4998@sigill.intra.peff.net>
References: <20120501084048.GA21904@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, dfowler <davidfowl@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com,
	Paul Betts <paul@github.com>, David Ebbo <david.ebbo@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: msysgit+bncCN2hpKqZChDOw_78BBoEvS2jYg@googlegroups.com Tue May 01 10:41:51 2012
Return-path: <msysgit+bncCN2hpKqZChDOw_78BBoEvS2jYg@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vb0-f58.google.com ([209.85.212.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCN2hpKqZChDOw_78BBoEvS2jYg@googlegroups.com>)
	id 1SP8ed-0007Hm-Ec
	for gcvm-msysgit@m.gmane.org; Tue, 01 May 2012 10:41:51 +0200
Received: by vbal1 with SMTP id l1sf3967561vba.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 May 2012 01:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=4uVKhh2luCQVCKCpQyvTYppbG//ivNfmKO5Cw6J25hk=;
        b=y/oqUFtFtucrOm2v9msMJZa8OmnpAMJHDRCRkJW0KBT+8wiG0iY+dRgBnS6dpWcjQ/
         gEVScs8g2cNLdOFHtzzcuhT28Cle8/hvNkiGkRIv1QMm+l0cSI9aPUyPfLanC4ZRErnh
         fdxYZm5gTzuoGoNU8TzHGnfzLcOyOE8iete/Q=
Received: by 10.50.183.201 with SMTP id eo9mr143098igc.3.1335861710304;
        Tue, 01 May 2012 01:41:50 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.56.204 with SMTP id c12ls2888391igq.2.canary; Tue, 01 May
 2012 01:41:49 -0700 (PDT)
Received: by 10.50.153.168 with SMTP id vh8mr976299igb.1.1335861709836;
        Tue, 01 May 2012 01:41:49 -0700 (PDT)
Received: by 10.50.153.168 with SMTP id vh8mr976298igb.1.1335861709828;
        Tue, 01 May 2012 01:41:49 -0700 (PDT)
Received: from peff.net (99-108-226-0.lightspeed.iplsin.sbcglobal.net. [99.108.226.0])
        by gmr-mx.google.com with ESMTPS id no9si8003826igc.0.2012.05.01.01.41.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 May 2012 01:41:49 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 99.108.226.0 as permitted sender) client-ip=99.108.226.0;
Received: (qmail 1781 invoked by uid 107); 1 May 2012 08:42:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 May 2012 04:42:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 May 2012 04:41:42 -0400
In-Reply-To: <20120501084048.GA21904@sigill.intra.peff.net>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peff@peff.net designates 99.108.226.0 as permitted sender) smtp.mail=peff@peff.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196670>

The send_pack_args struct has two verbosity flags: "quiet"
and "progress". Originally, if "quiet" was set, we would
tell pack-objects explicitly to be quiet, and if "progress"
was set, we would tell it to show progress. Otherwise, we
told it neither, and it relied on isatty(2) to make the
decision itself.

However, commit 01fdc21 changed the meaning of these
variables. Now both "quiet" and "!progress" instruct us to
tell pack-objects to be quiet (and a non-zero "progress"
means the same as before). This works well for transports
which call send_pack directly, as the transport code copies
transport->progress into send_pack_args->progress, and they
both have the same meaning.

However, the code path of calling "git send-pack" was left
behind. It always sets "progress" to 0, and thus always
tells pack-objects to be quiet.  We can work around this by
checking isatty(2) ourselves in the cmd_send_pack code path,
restoring the original behavior of the send-pack command.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/send-pack.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 9df341c..7d22715 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -492,6 +492,9 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (!args.quiet)
+		args.progress = isatty(2);
+
 	if (args.stateless_rpc) {
 		conn = NULL;
 		fd[0] = 0;
-- 
1.7.10.630.g31718

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en
