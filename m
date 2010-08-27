From: Chris Patti <cpatti@gmail.com>
Subject: Odd results writing a Git pre-receive hook to syntax check PHP files.
Date: Fri, 27 Aug 2010 17:07:00 -0400
Message-ID: <AANLkTikktdPoZN8MwJD+Gxus16xBGtScCAqT9W0eiWAb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 27 23:07:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op68k-0001hB-FS
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 23:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655Ab0H0VHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 17:07:04 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34606 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699Ab0H0VHC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 17:07:02 -0400
Received: by bwz11 with SMTP id 11so2245915bwz.19
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 14:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=l3W11YQtTxH3nbCK/kXOGZBZ7LzGjj27Y3qKhZjsAI8=;
        b=Ydjk7rsU+ZH8qV6MOtqhoizdwUvzWLoLLQ7k8srDCdZ2URDyr9/ab5iikicwMnex5h
         Jydt5zwN45tDpSjb7EUHItqmZE6hJ5hxU1vVp6mBYnyId8Vsdu0Er2LAFDamq+6XQ8gY
         qmVwQH3G7Biy9ir9GhEaDJOdKcUITADtmbwjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=YC01HW5iBwngrB2jEXdRRZx3Y1T4GriPgdgmsIzyGw+EfvND3wub1HpKbu3Kf3LQ65
         fZ6xKnkmWk/xzA0fr3TZXvjG3ANsiaUYBG9JezpOLsRbIWeGi3JYkggxlbQ4x4Rt7rXG
         46ZnPofnXBD4w3nHG+tueUeGQPxoI8nxS7gms=
Received: by 10.204.82.130 with SMTP id b2mr950228bkl.12.1282943220904; Fri,
 27 Aug 2010 14:07:00 -0700 (PDT)
Received: by 10.204.66.196 with HTTP; Fri, 27 Aug 2010 14:07:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154621>

Folks;

I'm trying to write a pre-receive hook to prevent syntactically bogus
PHP files from being 'push'ed into our master repository.

It's puzzling, my hook works *perfectly* on two different test repos,
but when I try to utilize it in an environment with lots of complex
branching, it exhibits totally (to me) unexplained behavior and fails
utterly.

Here's the correct behavior, in my test environments.  moo.php does
indeed have a syntax error.  foo.php is syntactically correct:

---
[16:50][admin@Chris-Patti:~/src/relengtest(master)]$ git push origin master
Counting objects: 5, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 363 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
ns: d372eddeb4a6bb69576c96458040c6bf44cdee79
os: f93a54b5bccc1630b61894f5041c0c6e105b47a3
refname: refs/heads/master

mode: 100644 type: blob blob: 372c38001f74f92264f77d448af27d8f6225db96
filename: foo.php
Checking foo.php
mode: 100644 type: blob blob: c10ecdacc38543a880c984a478a8c62399d22e81
filename: moo.php
Checking moo.php
There was a syntax error in 'moo.php'.  Rejecting this attempted merge!
error: hooks/pre-receive exited with error code 1
To ssh://git.bluestatedigital.com/home/git/relengtest.git
 ! [remote rejected] master -> master (pre-receive hook declined)
error: failed to push some refs to
'ssh://git.bluestatedigital.com/home/git/relengtest.git'
[16:50][admin@Chris-Patti:~/src/relengtest(master)]$

---

Great, right?  I'm taking the old and new refs in, doing git ls-tree
on the new_sha1 value to get the list of all the files included in
this commit,a nd their blob ids, and then using git show to get the
files contents and run them through the syntax checker.

Only, here's what happens when I put the identical hook into a
repository where I'm using a branch off a branch:
---
[17:01][admin@Chris-Patti:~/src/bsdrelease/test(bug-28046)]$ git push
origin bug-28046
Counting objects: 7, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 399 bytes, done.
Total 4 (delta 3), reused 0 (delta 0)
ns: d17233cfa4a7ae650a7fe0a97d336890a29a68c1
os: ad8e2e4f9510e1fbbd3ab58a58bf218ee2aa7150
refname: refs/heads/bug-28046

mode: 100644 type: blob blob: 9e2244625c3636978e8b44bce4ab2eb55bd100d6
filename: .gitignore
mode: 100755 type: blob blob: 9c1f0855a64f5ec0be3eebb9069ab2393602d662
filename: bin/bsdrelease
mode: 100755 type: blob blob: da2500c7f14cee33ab63477825390a8b7f22b74d
filename: bin/upgrade
mode: 100644 type: blob blob: a93a7616245d104711261a2dcaf71ff535aac737
filename: lib/Horde/Argv/Parser.php
Checking lib/Horde/Argv/Parser.php
mode: 100644 type: blob blob: 42337c2865ee6ace45afcf11c6dfd13b10ac36c6
filename: lib/Horde/Controller/Dispatcher.php
Checking lib/Horde/Controller/Dispatcher.php
mode: 100644 type: blob blob: 59f867badec965bf03c30eb06da0eb45c85aa033
filename: lib/Horde/Support/Inflector.php
Checking lib/Horde/Support/Inflector.php
mode: 100644 type: blob blob: f36f36d22ad9fa7dc1002d5d39926046a8505d58
filename: lib/bootstrap.inc.php
Checking lib/bootstrap.inc.php
mode: 100644 type: blob blob: 59d6fb573504abcc6c34aabec85fc73717e828bf
filename: lib/client_process.class.php
Checking lib/client_process.class.php
mode: 100644 type: blob blob: e3549d6a6f9ba62efb620bdf4127febad8a876b4
filename: lib/controllers/CcdeployController.php
Checking lib/controllers/CcdeployController.php
mode: 100644 type: blob blob: 74c9b9496a5e75ed39d35ec38fe907f0d1334f9a
filename: lib/controllers/ClientDbController.php
Checking lib/controllers/ClientDbController.php
mode: 100644 type: blob blob: 2d22560230ec3fe2d2ccc05439898b204243ec41
filename: lib/controllers/ClientInfoController.php
Checking lib/controllers/ClientInfoController.php
mode: 100644 type: blob blob: 2e22593ef858f53550132b0d9a200890dbfcbc30
filename: lib/controllers/ClientTarballController.php
Checking lib/controllers/ClientTarballController.php
mode: 100644 type: blob blob: c04828ac194914b9679e9a548e0331d891b9d59c
filename: lib/controllers/DeployController.php
Checking lib/controllers/DeployController.php
mode: 100644 type: blob blob: 12568d637a490c54708bb34b7103c3fd71cb4dc0
filename: lib/controllers/GenerateCreateScriptController.php
Checking lib/controllers/GenerateCreateScriptController.php
mode: 100644 type: blob blob: 081e4b213cbd5dc6d4459b932db1f7aea267de0d
filename: lib/controllers/GenerateUpgradeScriptController.php
Checking lib/controllers/GenerateUpgradeScriptController.php
mode: 100644 type: blob blob: 558ddc9f9aa73556791c19c946b6b4d359a07cab
filename: lib/controllers/ListClientsController.php
Checking lib/controllers/ListClientsController.php
mode: 100644 type: blob blob: 37fc6c28d4cce9bf48513a67d04c50692be69525
filename: lib/controllers/ListPackagesController.php
Checking lib/controllers/ListPackagesController.php
mode: 100644 type: blob blob: 225d5c4303962561cc36b7132e28ddb62099d52b
filename: lib/controllers/ListVersionsController.php
Checking lib/controllers/ListVersionsController.php
mode: 100644 type: blob blob: 0c814e7a8e880af7df96d5c4a3d6c77226bfbd4f
filename: lib/controllers/PrepareController.php
Checking lib/controllers/PrepareController.php
mode: 100644 type: blob blob: db3b743c3fe111fbd0b83448d419bd1e3d063d85
filename: lib/controllers/RollbackController.php
Checking lib/controllers/RollbackController.php
mode: 100644 type: blob blob: 9f12afed32cb26f617b0f2d2019fc084aea2d3dc
filename: lib/controllers/ServerUpdateController.php
Checking lib/controllers/ServerUpdateController.php
mode: 100644 type: blob blob: dca23654205f7e537769f8cd6a463377f5f61313
filename: lib/controllers/TestServersController.php
Checking lib/controllers/TestServersController.php
mode: 100644 type: blob blob: a15750987e7ad9d0ace814128cccd9af5bfab067
filename: lib/controllers/UpgradeController.php
Checking lib/controllers/UpgradeController.php
mode: 100644 type: blob blob: e8be9364b4b75a49dcb1bced52a76987791291a8
filename: lib/controllers/WriteDbConfigController.php
Checking lib/controllers/WriteDbConfigController.php
mode: 100644 type: blob blob: 4a97a4e122adc85db2d86273c59331881b6b8a7d
filename: lib/data/client__client_group.data.php
Checking lib/data/client__client_group.data.php
mode: 100644 type: blob blob: eb4b609dfba994b46159a60baa48f4e730d119d9
filename: lib/data/client__deploy_status.data.php
Checking lib/data/client__deploy_status.data.php
mode: 100644 type: blob blob: 4fdb4d9af394cc9224147cd54a81da7823336ead
filename: lib/data/client__package.data.php
Checking lib/data/client__package.data.php
mode: 100644 type: blob blob: cc343c87f754925ad55aeb029851f424fe4070d9
filename: lib/data/client_db_credentials.data.php
Checking lib/data/client_db_credentials.data.php
mode: 100644 type: blob blob: ed5777877daced5328a87826afcbbcaf27e2eb6f
filename: lib/data/client_group.data.php
Checking lib/data/client_group.data.php
mode: 100644 type: blob blob: 3efda2cf91c8af698a4314131c399ea835c2698d
filename: lib/data/clientconfig.data.php
Checking lib/data/clientconfig.data.php
mode: 100644 type: blob blob: d1e98c9162dc8245241024c96d20e8bd6d9add08
filename: lib/data/command.data.php
Checking lib/data/command.data.php
mode: 100644 type: blob blob: 8253f88e62ae965ee3b34b86f0427fdb3e9e9c9c
filename: lib/data/command_exception.data.php
Checking lib/data/command_exception.data.php
mode: 100644 type: blob blob: 2724fb1aaf3215330e82c18df3bb5cf48d1ed290
filename: lib/data/package.data.php
Checking lib/data/package.data.php
mode: 100644 type: blob blob: f2c5703f7976b1dfe9b5e2af8699092905a2f114
filename: lib/data/package_action.data.php
Checking lib/data/package_action.data.php
mode: 100644 type: blob blob: 80c78ddedc68659cf37969513d570200cf80a3ae
filename: lib/data/package_action__server.data.php
Checking lib/data/package_action__server.data.php
mode: 100644 type: blob blob: b76feab0a01b7f384721683b5d7525c76e5c0f56
filename: lib/data/package_version.data.php
Checking lib/data/package_version.data.php
mode: 100644 type: blob blob: a4d828188ee38d89d165e59bbc34d7beafd6bc62
filename: lib/data/prepared_package.data.php
Checking lib/data/prepared_package.data.php
mode: 100644 type: blob blob: 61895931ce58a9353a419a809fad0c88c6d6b6bc
filename: lib/data/server.data.php
Checking lib/data/server.data.php
mode: 100644 type: blob blob: ab265140deec0e0e83344d54878040a5f72470c1
filename: lib/fork.php
Checking lib/fork.php
mode: 100644 type: blob blob: bd5b8e9648afd2ab87730ad1dfeea5651a038ff4
filename: lib/model_rules/generate_create_script_rules.class.php
Checking lib/model_rules/generate_create_script_rules.class.php
mode: 100644 type: blob blob: 7677f4f5c22112913e8fcba3552943c04e12bfbd
filename: lib/model_rules/generate_upgrade_script_rules.class.php
Checking lib/model_rules/generate_upgrade_script_rules.class.php
mode: 100644 type: blob blob: e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
filename: lib/packages/ee.php
Checking lib/packages/ee.php
mode: 100644 type: blob blob: e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
filename: lib/packages/framework.php
Checking lib/packages/framework.php
mode: 100644 type: blob blob: 392bf1322466b7fbec368cea554e76639bd5a340
filename: lib/rules/client_spec_rules.class.php
Checking lib/rules/client_spec_rules.class.php
mode: 100644 type: blob blob: 282968efad5ec81313b9dde87e7701515d571bf6
filename: lib/rules/rulesets/client_spec_ruleset.class.php
Checking lib/rules/rulesets/client_spec_ruleset.class.php
mode: 100644 type: blob blob: 15ea52e6f84ffdd75cf9a9185b8e82adffbf6a41
filename: lib/views/cli/ApproveCreateScript/index.php
Checking lib/views/cli/ApproveCreateScript/index.php
mode: 100644 type: blob blob: 5add2d63da8b4d0dc200b17479416ce3e19c829b
filename: lib/views/cli/ApproveUpgradeScript/index.php
Checking lib/views/cli/ApproveUpgradeScript/index.php
mode: 100644 type: blob blob: ffb26436f4de184d11246ae7733154e0146cf27e
filename: lib/views/cli/ClientInfo/index.php
Checking lib/views/cli/ClientInfo/index.php
mode: 100644 type: blob blob: 0e2e27d075d304d110eae6be6c882fdfedd23106
filename: lib/views/cli/Deploy/help.php
Checking lib/views/cli/Deploy/help.php
mode: 100644 type: blob blob: ec17db9d9bab632c1e547f2ac6a677a16ceea899
filename: lib/views/cli/Deploy/index.php
Checking lib/views/cli/Deploy/index.php
mode: 100644 type: blob blob: 85ebed31e40022abb5ba3b1ca4ffa9087b1e2969
filename: lib/views/cli/Error/index.php
Checking lib/views/cli/Error/index.php
mode: 100644 type: blob blob: cba0e73c2feed28a20cd58a3f4fe0b4c9828ccef
filename: lib/views/cli/GenerateCreateScript/index.php
Checking lib/views/cli/GenerateCreateScript/index.php
mode: 100644 type: blob blob: cd36ee08d3985be02960a5767fe47f3b971595ca
filename: lib/views/cli/GenerateUpgradeScript/index.php
Checking lib/views/cli/GenerateUpgradeScript/index.php
mode: 100644 type: blob blob: 6001717f37ff194ef465e5c5e3bfdeecc4155a5a
filename: lib/views/cli/ListClients/help.php
Checking lib/views/cli/ListClients/help.php
mode: 100644 type: blob blob: ba741522b3cc80cb03bb8fa893158f5956a4b135
filename: lib/views/cli/ListClients/index.php
Checking lib/views/cli/ListClients/index.php
mode: 100644 type: blob blob: a82be806ff53d1cd428efc095358ba51b7b194be
filename: lib/views/cli/ListPackages/help.php
Checking lib/views/cli/ListPackages/help.php
mode: 100644 type: blob blob: 5a2f724ad94c1d5650d62b971a4cd6d6c4bd7826
filename: lib/views/cli/ListPackages/index.php
Checking lib/views/cli/ListPackages/index.php
mode: 100644 type: blob blob: 4faf3a7631ad89aa74dcb41362b78de0af5af2ab
filename: lib/views/cli/ListVersions/help.php
Checking lib/views/cli/ListVersions/help.php
mode: 100644 type: blob blob: 7e26a74730ddc5ac282de483e7b1951a0c0a7ac2
filename: lib/views/cli/ListVersions/index.php
Checking lib/views/cli/ListVersions/index.php
mode: 100644 type: blob blob: 3609700fb37f9919222ce0600eb2329aad3d5615
filename: lib/views/cli/Prepare/help.php
Checking lib/views/cli/Prepare/help.php
mode: 100644 type: blob blob: 567d8074e044e180251f94232ab3ffe386e01e6b
filename: lib/views/cli/Prepare/index.php
Checking lib/views/cli/Prepare/index.php
mode: 100644 type: blob blob: eb12d2ddedde8dec0514c4711dd055af30156b19
filename: lib/views/cli/ServerUpdate/index.php
Checking lib/views/cli/ServerUpdate/index.php
mode: 100644 type: blob blob: 0fdbb9cbe18b682e866f33e6bdcec587a5227784
filename: lib/views/cli/Upgrade/help.php
Checking lib/views/cli/Upgrade/help.php
mode: 100644 type: blob blob: 7877eac48fc7ed8a979504413d333f7aabe97b62
filename: lib/views/cli/layouts/application.php
Checking lib/views/cli/layouts/application.php
mode: 100644 type: blob blob: 9af564990a00f91e00f373f7f25970529a0e0e87
filename: lib/views/cli/shared/_standardOptions.php
Checking lib/views/cli/shared/_standardOptions.php
mode: 100644 type: blob blob: 5fdfefcd2edfc190565af4a7b995fc84729bec35
filename: lib/views/cli/shared/_validationErrors.php
Checking lib/views/cli/shared/_validationErrors.php
mode: 100644 type: blob blob: 0710b520db1e6beba4c9bbf14eaee6fa8dd9d68a
filename: lib/views/html/Deploy/help.php
Checking lib/views/html/Deploy/help.php
mode: 100644 type: blob blob: ae03e2ee5b2845b705fac383903787fcef61dd4b
filename: lib/views/html/Error/index.php
Checking lib/views/html/Error/index.php
mode: 100644 type: blob blob: fcd069bb109fa8689987fa541fd6eb4f7ce78165
filename: lib/views/html/ListClients/help.php
Checking lib/views/html/ListClients/help.php
mode: 100644 type: blob blob: ef99eaf1eae653db24195724847808173a8c421a
filename: lib/views/html/ListClients/index.php
Checking lib/views/html/ListClients/index.php
mode: 100644 type: blob blob: fd0592aa00ab76081b42579f94e5b8a26e4c83a8
filename: lib/views/html/ListClients/input.php
Checking lib/views/html/ListClients/input.php
mode: 100644 type: blob blob: 917befbf76d3658cbb769c351563d5cf115f5f3e
filename: lib/views/html/ListPackages/help.php
Checking lib/views/html/ListPackages/help.php
mode: 100644 type: blob blob: 083b172802ec09cac79a209c343a7c0ec5605e47
filename: lib/views/html/ListPackages/index.php
Checking lib/views/html/ListPackages/index.php
mode: 100644 type: blob blob: a2f62f2e826dcc96b6c7aa0eac30067884f4971e
filename: lib/views/html/ListVersions/help.php
Checking lib/views/html/ListVersions/help.php
mode: 100644 type: blob blob: 9ee8a316bfbad950389500a334806bbdbe7efcf1
filename: lib/views/html/ListVersions/index.php
Checking lib/views/html/ListVersions/index.php
mode: 100644 type: blob blob: ffa4ce8ca633ca8e8d7cf818b091e89301972d25
filename: lib/views/html/layouts/application.php
Checking lib/views/html/layouts/application.php
mode: 100644 type: blob blob: 8a0cf604dbe88d41bbf18b27562c61b71612e6e3
filename: lib/views/html/shared/_standardOptions.php
Checking lib/views/html/shared/_standardOptions.php
mode: 100644 type: blob blob: 3f9c8db23f4517fa0aff311b6036324dbbf1547e
filename: lib/views/html/shared/_validationErrors.php
Checking lib/views/html/shared/_validationErrors.php
mode: 100755 type: blob blob: 0ed20cbaa2ebefc6b473ef19e2f0534916fe8401
filename: scripts/clean_sandbox.sh
mode: 100755 type: blob blob: 3460ac158ec6e49d18947659a88f89fee6742005
filename: scripts/client_atomicity_cutover.sh
mode: 100755 type: blob blob: 605fe7efe119e13e608010c500e8d46a9aa78678
filename: scripts/consolidate-links.py
mode: 100755 type: blob blob: 937fd93c9dec4ccbd097a0c738308e294555e074
filename: scripts/cutover_client.sh
mode: 100755 type: blob blob: 8de04dd40f433abc83e55694c0b18fe8e8a4be5f
filename: scripts/mk_client_repos.sh
mode: 100755 type: blob blob: 683e36ed7736d8dafaff73ddc25d8eceb2184ff7
filename: scripts/new_client_setup.sh
mode: 100755 type: blob blob: 50215aad6a97654524a19cec45863c22f75338de
filename: scripts/push_branch.sh
mode: 100755 type: blob blob: b562aef0d6184919a1867d38d884cec8b5d0b8cb
filename: scripts/release/create-migrations.sh
mode: 100755 type: blob blob: 85161b45e9cda0d9c11ae855ebe7f9352fef624a
filename: scripts/release/deploy-mailer-compat.sh
mode: 100755 type: blob blob: c3d147d2129320941d9ffba072f29378fae6f6f2
filename: scripts/release/find-merged-branches.sh
mode: 100755 type: blob blob: 81e81767bb05fa037598e308e4870f08fff8314e
filename: scripts/release/mailer-compat.sh
mode: 100755 type: blob blob: 84db6a40b1aaefe87d62f06a86f566041563e6a5
filename: scripts/release/tag-deploy-config.sh
mode: 100755 type: blob blob: 5a359fff5e6c0590c3bcea43b16420217f50a285
filename: scripts/release/tag-release.sh
mode: 100755 type: blob blob: ce1256c79a87e7d6e34f6d8dd539e6cb7187d595
filename: scripts/remove_cvs_dirs.sh
mode: 100755 type: blob blob: f2941728666e41d44c0a90b1f3640920de3bb99f
filename: scripts/remove_cvs_dirs_group.sh
mode: 100755 type: blob blob: 0a1a3e1cc43f693f941405030318d0ee55379d5b
filename: scripts/remove_cvs_dirs_server.sh
mode: 100755 type: blob blob: 52d399655cba3f4dbf6b052a44626cad2136d9a2
filename: scripts/remove_scratch_dirs.sh
mode: 100755 type: blob blob: 5cb2eed1bb0ce1e3f59f5e0bba2f39cf1578b433
filename: scripts/shared_resources_client_update.sh
mode: 100755 type: blob blob: f6fd4a715ff2165e58e7ae469b7f2beffd10683e
filename: scripts/show_cv.sh
mode: 100755 type: blob blob: 2c6fdbff1cc764d17162f4c926ac19c5e7a3771e
filename: scripts/show_cv_json.sh
mode: 100644 type: blob blob: 0d1fa845d2d1cfc068df2c3d91408b1ff8ea428f
filename: test/.gitignore
mode: 100644 type: blob blob: c8a970f86b3279c824e750304ae7dcd1c671f9ef
filename: test/BlueTestCase.php
Checking test/BlueTestCase.php
mode: 100644 type: blob blob: a46ad98c60b25e344e35a7ece5581ed8da8ba37b
filename: test/BlueTestSuite.php
Checking test/BlueTestSuite.php
mode: 100644 type: blob blob: d649763699177b566c060471eba98ef0d6b60934
filename: test/CommandExposer.php
Checking test/CommandExposer.php
mode: 100755 type: blob blob: 14740e1d5b8110d4bd61a01b46f2dd55a030016b
filename: test/bsdunit
mode: 100644 type: blob blob: 8c4c794ff20baf349c966a03a5d78e1ae0151b31
filename: test/fixtures/ClientConfigFixtures.php
Checking test/fixtures/ClientConfigFixtures.php
mode: 100644 type: blob blob: a3a3c4b4a349ac8d322187b3e638cc8b7c4a853f
filename: test/morebogus.php
Checking test/morebogus.php
There was a syntax error in 'test/morebogus.php'.  Rejecting this
attempted merge!
error: hooks/pre-receive exited with error code 1
To ssh://git.bluestatedigital.com/home/git/bsdrelease
 ! [remote rejected] bug-28046 -> bug-28046 (pre-receive hook declined)
error: failed to push some refs to
'ssh://git.bluestatedigital.com/home/git/bsdrelease'
[17:01][admin@Chris-Patti:~/src/bsdrelease/test(bug-28046)]$

Why is git ls-tree returning all those blobs that are totally
unrelated to my check-in, and how can I constrain the files I'm syntax
checking to only those in the current commit?

Thanks for any insights!
-Chris
(The hook source is at: http://pastebin.com/TVXVfDVi and also directly
below.  I used PHP because this is a 100% PHP shop, but I'm reasonably
certain that's not the issue.)
---
#!/home/php/bin/php
<?php

$fpstdin = fopen("php://stdin","r");

$line = fgets($fpstdin);

list($old_sha1,$new_sha1,$refname)=explode(" ",$line);

echo "ns: $new_sha1\n";
echo "os: $old_sha1\n";
echo "refname: $refname\n";

$lstree = array();

exec("git ls-tree -r $new_sha1",$lstree,$lsrcval);
if ($lsrcval != 0) {
        echo "Syntax checker hook is malfunctioning.  Can't execute
git ls-tree.  Failing gracefully and allowing this push.\n";
};

# If we can execute the git ls-tree I'm assuming we have access to a
working git.


foreach ($lstree as &$lstline) {
        list($rest,$filename) = explode('       ',$lstline);
        list($mode,$type,$blob) = explode(" ",$rest);
        echo "mode: $mode type: $type blob: $blob filename: $filename\n";

        $needle = '/(\.php|\.module|\.install)$/';
        if (preg_match($needle,$filename)) {
                echo "Checking $filename\n";
                $dummy = array();
                exec("git show $blob|/home/php/bin/php -l",$dummy,$checkrcval);
                if ($checkrcval != 0) {
                        echo "There was a syntax error in '$filename'.
 Rejecting this attempted merge!\n";
                        exit(1);
                }
        }
}

exit(0);

-- 
Christopher Patti - Geek At Large | GTalk: cpatti@gmail.com | AIM:
chrisfeohpatti | P: (260) 54PATTI
"Technology challenges art, art inspires technology." - John Lasseter, Pixar
