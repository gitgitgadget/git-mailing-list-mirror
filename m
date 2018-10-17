Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4E681F453
	for <e@80x24.org>; Wed, 17 Oct 2018 08:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeJQQ1K (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 12:27:10 -0400
Received: from mail.nudt.edu.cn ([202.197.9.11]:43832 "EHLO nudt.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726967AbeJQQ1J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 12:27:09 -0400
Received: by ajax-webmail-app2 (Coremail) ; Wed, 17 Oct 2018 16:34:06 +0800
 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
X-Originating-IP: [43.250.201.107]
Date:   Wed, 17 Oct 2018 16:34:06 +0800 (GMT+08:00)
From:   =?UTF-8?B?54mb5pet?= <niuxu16@nudt.edu.cn>
To:     git <git@vger.kernel.org>
Subject: Recommendations for  adding strerror() in log statament
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 5.0.3_preview build
 20151102(76855.8176) Copyright (c) 2002-2018 www.mailtech.cn nudt
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4413c65c.101fa.16681291a04.Coremail.niuxu16@nudt.edu.cn>
X-CM-TRANSID: SIAQrABHp1T_88ZbdoERBg--.16301W
X-CM-SenderInfo: xqlx53qrw603lgwovvfxof0/1tbiAQEBDFC8UnQCigABsO
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Our team works on enhance logging practices by learning from historical log revisions in evolution.
And we find 2 patches that add strerror() to the log statement which is printed when the return value of commit_lock_file() is smaller than 0.

While applying this rule to git-2.14.2, we find 3 missed spots. 
We suggest to add strerror() or just use error_errno() instead of error().

Here are the missed spots:
1) Line 307 in file git-2.14.2/sequencer.c:
static int write_message(const void *buf, size_t len, const char *filename,
			 int append_eol)
{
	...
	if (append_eol && write(msg_fd, "\n", 1) < 0) {
		rollback_lock_file(&msg_file);
		return error_errno(_("could not write eol to '%s'"), filename);
	}
	if (commit_lock_file(&msg_file) < 0) {
		rollback_lock_file(&msg_file);
		return error(_("failed to finalize '%s'."), filename);
	}

2) Line 1582 in file git-2.14.2/sequencer.c:
static int save_head(const char *head)
{
	...
	strbuf_addf(&buf, "%s\n", head);
	if (write_in_full(fd, buf.buf, buf.len) < 0) {
		rollback_lock_file(&head_lock);
		return error_errno(_("could not write to '%s'"),
				   git_path_head_file());
	}
	if (commit_lock_file(&head_lock) < 0) {
		rollback_lock_file(&head_lock);
		return error(_("failed to finalize '%s'."), git_path_head_file());
	}

3) Line 1706 in file git-2.14.2/sequencer.c:
static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
{
	...
	if (write_in_full(fd, todo_list->buf.buf + offset,
			todo_list->buf.len - offset) < 0)
		return error_errno(_("could not write to '%s'"), todo_path);
	if (commit_lock_file(&todo_lock) < 0)
		return error(_("failed to finalize '%s'."), todo_path);


Following are the 2 patches that support our opinion:
1) Line 2147 in file git-2.6.4/config.c:
 	if (commit_lock_file(lock) < 0) {
-		error("could not commit config file %s", config_filename);
+		error("could not write config file %s: %s", config_filename,
+		      strerror(errno));
 		ret = CONFIG_NO_WRITE;
 		lock = NULL;
 		goto out_free;
 	}

2) Line 2333 in file git-2.6.4/config.c:
 unlock_and_out:
 	if (commit_lock_file(lock) < 0)
-		ret = error("could not commit config file %s", config_filename);
+		ret = error("could not write config file %s: %s",
+			    config_filename, strerror(errno));
 out:
 	free(filename_buf);

Thanks for reading, we are looking forward to your reply about the correctness of our suggestion~
May you a good day ^^

Best regards,
Xu

